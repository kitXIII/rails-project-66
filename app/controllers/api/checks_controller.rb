# frozen_string_literal: true

class Api::ChecksController < Api::ApplicationController
  def create
    repository = Repository.find_by! github_id: params[:repository][:id]

    check = repository.checks.create!
    RepositoryCheckerJob.perform_later(check.id)

    head :no_content
  end

  def check_params
    params.permit
  end
end
