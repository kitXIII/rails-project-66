# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    provider = params[:provider]
    user = find_or_initialize_user(auth, provider)

    if user.save
      sign_in(user)
      redirect_to root_path, notice: t('auth_success')
    else
      redirect_to root_path, alert: user.errors.full_messages.to_sentence
    end
  end

  def logout
    sign_out
    redirect_to root_path
  end

  private

  def find_or_initialize_user(auth, provider)
    user = User.find_or_initialize_by(email: auth[:info][:email].downcase)
    user.token = auth[:credentials][:token]

    return user if user.persisted?

    user.provider = provider
    user.uid = auth[:uid]
    user.nickname = auth[:info][:nickname]
    user.email = auth[:info][:email]

    user
  end
end
