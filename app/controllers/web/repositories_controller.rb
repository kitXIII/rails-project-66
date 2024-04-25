# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @repositories = current_user.repositories.order(updated_at: :desc)
  end

  def new
    @repository = Repository.new

    @github_repos = Rails.cache.fetch([current_user.id, session[:login_ts], :repos], expires_in: 10.minutes) do
      GithubHelper.fetch_user_repos(current_user)
    end
  end

  def create
    redirect_to repositories_path
  end
end
