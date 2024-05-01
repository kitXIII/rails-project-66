# frozen_string_literal: true

class Web::Repositories::ChecksController < Web::Repositories::ApplicationController
  def show
    resource_repository
  end

  def create
    redirect_to repository_path(resource_repository), t('.success')
  end
end
