# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  before_action :authenticate_user!

  def index
    @repositories = current_user.repositories.order(updated_at: :desc)
  end

  def new
    @repository = Repository.new
    @github_repos = GithubHelper.fetch_user_repos(current_user)
  end

  def create
    redirect_to repositories_path
  end
end
