# frozen_string_literal: true

class RepositoryChecker
  include Import['repository_check_client']

  def run(repository_check)
    return unless repository_check.may_start?

    work_dir_path = Rails.root.join('tmp/repos', repository_check.id.to_s)
    repository_check.start!
    commit_id = repository_check_client.clone_repo(repository_check.repository.clone_url, work_dir_path)
    linter = "Linter::#{repository_check.repository.language.capitalize}Linter".constantize.new
    result = repository_check_client.run_check(linter.command, work_dir_path)
    files = linter.build_files_with_flaws(result, work_dir_path)

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
    repository_check.passed = repository_check.flaws_count.zero?
    repository_check_client.clean_work_dir_if_exists(work_dir_path)
    repository_check.finish!
    RepositoryCheckMailer.check_found_flaws_email(repository_check.id).deliver_later unless repository_check.passed
  rescue StandardError => e
    Rails.logger.error e
    repository_check_client.clean_work_dir_if_exists(work_dir_path)
    repository_check.fail!
    RepositoryCheckMailer.check_failed_email(repository_check.id).deliver_later
  end
end
