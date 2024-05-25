# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def show
    @check = resource_repository.checks.find params[:id]
    authorize @check
  end

  def create
    @check = resource_repository.checks.build
    authorize @check

    if @check.save
      RepositoryCheckJob.perform_later(@check.id)

      redirect_to repository_path(resource_repository), notice: t('.success')
    else
      redirect_to repository_path(resource_repository), notice: t('.failure')
    end
  end
end
