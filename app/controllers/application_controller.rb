# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthConcern
  include Pundit::Authorization

  helper_method :current_user, :signed_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    alert = t "#{policy_name}.#{exception.query}", scope: :pundit, default: :default
    redirect_back(fallback_location: root_path, alert:)
  end
end
