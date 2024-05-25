# frozen_string_literal: true

class RepositoryCheckRunJob < ApplicationJob
  queue_as :default

  def perform(repository_check_id)
    repository_check_helper = ApplicationContainer['repository_check_helper']

    repository_check = Repository::Check.find repository_check_id

    return unless repository_check&.may_start?

    repository_check.start!

    work_dir_path = Rails.root.join('tmp/repos', repository_check_id.to_s)

    repository_check_helper.prepare_work_dir(work_dir_path)

    commit_id = repository_check_helper.clone_repo(repository_check.repository.clone_url, work_dir_path)

    result = repository_check_helper.run_check(Linter::Ruby.command, work_dir_path)

    files = Linter::Ruby.transform(result)

    files.each do |file|
      check_file = Repository::Check::File.create(path: file.path, check: repository_check)

      file.flaws.each do |flaw|
        Repository::Check::Flaw.create(
          rule: flaw.rule,
          message: flaw.message,
          location: flaw.location,
          file: check_file,
          check: repository_check
        )
      end
    end

    repository_check.commit_id = commit_id
    repository_check.save

    repository_check_helper.clean_work_dir_if_exists(work_dir_path)
    repository_check.finish!
  rescue StandardError
    repository_check_helper.clean_work_dir_if_exists(work_dir_path)
    repository_check.fail!
  end
end
