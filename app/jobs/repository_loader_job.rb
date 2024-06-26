# frozen_string_literal: true

class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)

    return unless repository

    github_data = GithubClient.fetch_repo_data(repository)

    params = {
      name: github_data[:name],
      full_name: github_data[:full_name],
      language: github_data[:language].downcase,
      clone_url: github_data[:clone_url],
      html_url: github_data[:html_url]
    }

    repository.update!(params)
    GithubClient.add_repo_check_hook(repository)
  end
end
