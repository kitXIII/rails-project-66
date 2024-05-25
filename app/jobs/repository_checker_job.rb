# frozen_string_literal: true

class RepositoryCheckerJob < ApplicationJob
  queue_as :default

  def perform(repository_check_id)
    repository_check = Repository::Check.find repository_check_id

    RepositoryChecker.new.run(repository_check) if repository_check
  end
end
