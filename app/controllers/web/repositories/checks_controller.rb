# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def show
    @check = Repository::Check.find params[:id]
    authorize @check
  end

  def create
    @check = resource_repository.build
    authorize @check

    redirect_to repository_path(resource_repository), t('.success')
  end
end
