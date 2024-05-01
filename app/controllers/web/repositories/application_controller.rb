# frozen_string_literal: true

class Web::Repositories::ApplicationController < Web::ApplicationController
  before_action :authenticate_user!

  def resource_repository
    @resource_repository ||= current_user.repositories.find params[:repository_id]
  end
end
