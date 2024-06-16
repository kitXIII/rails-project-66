# frozen_string_literal: true

class Web::Repositories::ApplicationController < Web::ApplicationController
  before_action :authenticate_user!

  def resource_repository
    @resource_repository ||= Repository.find(params[:repository_id])
  end
end
