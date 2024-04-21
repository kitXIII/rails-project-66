# frozen_string_literal: true

require 'test_helper'

class Web::AuthControllerTest < ActionDispatch::IntegrationTest
  test 'check github auth' do
    post auth_request_path('github')

    assert_response :redirect
  end

  test 'create' do
    auth_hash = {
      provider: 'github',
      uid: '12345',
      info: {
        email: Faker::Internet.email,
        nickname: Faker::Internet.username
      },
      credentials: {
        token: Faker::Internet.uuid
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_url('github')

    assert_response :redirect

    user = User.find_by(email: auth_hash[:info][:email].downcase)

    assert user.token

    assert_predicate self, :signed_in?
  end

  test 'logout' do
    sign_in(users(:one))

    delete logout_auth_url

    assert_response :redirect

    assert_not signed_in?
  end
end
