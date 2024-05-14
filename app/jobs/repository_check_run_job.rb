# frozen_string_literal: true

class RepositoryCheckRunJob < ApplicationJob
  queue_as :default

  def perform(repository_check_id)
    repository_check = Repository::Check.find repository_check_id

    return unless repository_check&.may_start?

    repository_check.start!

    work_dir_path = Rails.root.join('tmp', repository_check_id.to_s)

    FileUtils.rm_rf(work_dir_path) if work_dir_path.exist?
    FileUtils.mkdir_p(work_dir_path)

    # _r, _e, status = Open3.capture3("git clone #{repository_check.repository.clone_url} .", chdir: work_dir_path)
    # r, _e, status = Open3.capture3('git log --format="%h" -n 1', chdir: work_dir_path)
    # commit_id = r.chomp

    # _r, _e, status = Open3.capture3("git clone #{repo.clone_url} .", chdir: work_dir_path)

    # exit_status = Open3.popen3("git clone #{repo.clone_url} .", chdir: work_dir_path) { |_i, _o, _e, t| t.value }
    # unless status.succcess?
    #   repository_check.mark_as_failed!

    #   return
    # end

    # Clone repo
    # Get info from cloned repo: git log --format="%h" -n 1
    # Start checking

    puts repository_check.repository.id
  end
end
