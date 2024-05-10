# frozen_string_literal: true

class RepositoryCheckRunJob < ApplicationJob
  queue_as :default

  def perform(repository_check_id)
    repository_check = Repository::Check.find repository_check_id

    return unless repository_check

    # Get commit_id info
    # Prepare work directory
    # Clone repo
    # Start checking

    puts repository_check.repository.id
  end
end
