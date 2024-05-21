# frozen_string_literal: true

class RepositoryCheckRunJob < ApplicationJob
  queue_as :default

  def perform(repository_check_id)
    repository_check = Repository::Check.find repository_check_id

    return unless repository_check&.may_start?

    repository_check.start!

    work_dir_path = Rails.root.join('tmp', repository_check_id.to_s)

    RepositoryCheckHelper.prepare_work_dir(work_dir_path)

    commit_id = RepositoryCheckHelper.clone_repo(repository_check.repository.clone_url, work_dir_path)

    command = "rubocop -f json -c #{Rails.root.join('lib/linter_configs/rubocop.yml')}"

    result = RepositoryCheckHelper.run_check(command, work_dir_path)

    result['files'].each do |f|
      next if f['offenses'].empty?

      check_file = Repository::Check::File.create(path: f['path'], check: repository_check)

      f['offenses'].each do |o|
        Repository::Check::File::Problem.create(
          rule: o['cop_name'],
          message: o['message'],
          location: "#{o['location']['line']}:#{o['location']['column']}",
          file: check_file
        )
      end
    end

    repository_check.commit_id = commit_id
    repository_check.result = result['summary']['offense_count'].zero?
    repository_check.save

    RepositoryCheckHelper.clean_work_dir_if_exists(work_dir_path)
    repository_check.finish!
  rescue StandardError
    RepositoryCheckHelper.clean_work_dir_if_exists(work_dir_path)
    repository_check.fail!
  end
end
