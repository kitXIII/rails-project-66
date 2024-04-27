# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find repository_id

    repository.fetch!

    github_data = GithubHelper.fetch_repo_data(repository)

    repository.update!(
      name: github_data[:name],
      full_name: github_data[:full_name],
      language: github_data[:language],
      clone_url: github_data[:clone_url],
      ssh_url: github_data[:ssh_url]
    )

    repository.mark_as_fetched!
  rescue StandardError
    repository&.mark_as_failed!
  end
end
