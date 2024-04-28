# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)

    @attrs = {
      github_id: 123_456_789
    }
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
    sign_in(@user)
    get new_repository_url

    assert_response :success
  end

  test 'should not allow to post create when user is not logged in' do
    post repositories_url, params: { repository: @attrs }

    repository = Repository.find_by @attrs

    assert { repository.nil? }

    assert_redirected_to root_url
  end

  test 'should create post when user is logged in' do
    sign_in(@user)
    post repositories_url, params: { repository: @attrs }

    repository = Repository.find_by @attrs

    assert { repository.fetched? }
    assert { repository.user == @user }

    assert_redirected_to repositories_url
  end
end
