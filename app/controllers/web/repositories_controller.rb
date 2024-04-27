# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :authenticate_user!
  before_action :set_github_repos, only: %i[new create]

  def index
    @repositories = current_user.repositories.order(updated_at: :desc)
  end

  def new
    @repository = Repository.new
  end

  def create
    @repository = current_user.repositories.build(repository_params)

    redirect_to repositories_path
  end

  private

  def repository_params
    params.require(:repository).permit(:github_id)
  end

  def set_github_repos
    @github_repos = Rails.cache.fetch([current_user.id, session[:login_ts], :repos], expires_in: 10.minutes) do
      GithubHelper.fetch_available_user_repos(current_user)
    end
  end
end
