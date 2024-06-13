# frozen_string_literal: true

class RepositoryCheckerJob < ApplicationJob
  queue_as :default

  def perform(repository_check_id)
    repository_check = Repository::Check.find repository_check_id

    return unless repository_check

    RepositoryChecker.new.run(repository_check)

    RepositoryCheckMailer.check_failed_email(repository_check.id).deliver_later if repository_check.failed?

    return if repository_check.passed

    RepositoryCheckMailer.check_found_flaws_email(repository_check.id).deliver_later
  end
end
