# frozen_string_literal: true

class RepositoryLoadJob < ApplicationJob
  queue_as :default

  def perform(repository_id)
    repository = Repository.find repository_id

    return unless repository

    github_data = GithubHelper.fetch_repo_data(repository)

    params = {
      name: github_data[:name],
      full_name: github_data[:full_name],
      language: github_data[:language].downcase,
      clone_url: github_data[:clone_url],
      html_url: github_data[:html_url]
    }

    repository.update!(params)

    check = repository.checks.create
    RepositoryCheckJob.perform_later(check.id)
  end
end
