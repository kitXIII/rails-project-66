# frozen_string_literal: true

class GithubHelper
  class << self
    def fetch_user_repos(user)
      client = Octokit::Client.new access_token: user.token, auto_paginate: true

      client.repos
    end
  end
end
