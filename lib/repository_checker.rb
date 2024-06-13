# frozen_string_literal: true

class RepositoryChecker
  include Import['repository_check_helper']

  def run(repository_check)
    return unless repository_check.may_start?

    work_dir_path = Rails.root.join('tmp/repos', repository_check.id.to_s)

    repository_check.start!

    commit_id = repository_check_helper.clone_repo(repository_check.repository.clone_url, work_dir_path)

    linter = "Linter::#{repository_check.repository.language.capitalize}Linter".constantize.new

    result = repository_check_helper.run_check(linter.command, work_dir_path)

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

    repository_check_helper.clean_work_dir_if_exists(work_dir_path)
    repository_check.finish!
  rescue StandardError => e
    Rails.logger.error e

    repository_check_helper.clean_work_dir_if_exists(work_dir_path)
    repository_check.fail!
  end
end
