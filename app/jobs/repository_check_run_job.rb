# frozen_string_literal: true

class RepositoryCheckRunJob < ApplicationJob
  queue_as :default

  def perform(repository_check_id)
    repository_check = Repository::Check.find repository_check_id

    return unless repository_check&.may_start?

    repository_check.start!

    work_dir_path = Rails.root.join('tmp', repository_check_id.to_s)

    RepositoryCheckHelper.prepare_work_dir(work_dir_path)

    result = RepositoryCheckHelper.clone_repo(repository_check.repository.clone_url, work_dir_path)

    repository_check.commit_id = result
    repository_check.save

    # command = "rubocop -f json -c #{Rails.root.join('lib/linter_configs/rubocop.yml')}"

    # result = RepositoryCheckHelper.run_check(command, work_dir_path)

    # result.files[i].path - проверить, если что отчистить путь
    # result.files[i].offenses[j].message - сообщение
    # result.files[i].offenses[j].cop_name - правило
    # result.files[i].offenses[j].location.line - часть для составления line:column
    # result.files[i].offenses[j].location.column - часть для составления line:column

    RepositoryCheckHelper.clean_work_dir_if_exists(work_dir_path)
    repository_check.finish!
  rescue StandardError
    RepositoryCheckHelper.clean_work_dir_if_exists(work_dir_path)
    repository_check.fail!
  end
end
