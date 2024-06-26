# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def show
    @check = resource_repository.checks.includes(files: [:flaws]).find(params[:id])
    authorize @check
  end

  def create
    @check = resource_repository.checks.build
    authorize @check

    if @check.save
      RepositoryCheckerJob.perform_later(@check.id)

      redirect_to repository_path(resource_repository), notice: t('.success')
    else
      redirect_to repository_path(resource_repository), notice: t('.failure')
    end
  end
end
