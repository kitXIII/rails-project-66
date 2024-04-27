# frozen_string_literal: true

module GithubHelper
  class << self
    def client(user)
      ApplicationContainer[:octokit_client].new access_token: user.token, auto_paginate: true
    end

    def fetch_available_user_repos(user)
      client(user).repos
                  .select { |r| Repository.language.values.include? r.language.downcase }
    end

    def fetch_repo_data(repository)
      client(repository.user).repo(repository.github_id)
    end
  end
end
