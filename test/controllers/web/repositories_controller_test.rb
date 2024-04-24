# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should not get index when user is not logged in' do
    get repositories_url

    assert_redirected_to root_url
  end

  test 'should get index when user is logged in' do
    sign_in(@user)
    get repositories_url

    assert_response :success
  end

  test 'should not get new when user is not logged in' do
    get new_repository_url

    assert_redirected_to root_url
  end

  test 'should get new when user is logged in' do
    repositories_response = load_fixture('files/repositories.json')

    stub_request(:get, 'https://api.github.com/user/repos?per_page=100')
      .to_return(
        status: 200,
        body: repositories_response,
        headers: { 'Content-Type' => 'application/json' }
      )

    sign_in(@user)
    get repositories_url

    assert_response :success
  end
end
