# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)

    @attrs = {
      github_id: 123_456_789
    }

    @repository_exists = repositories(:one)
    @repository_belongs_to_another_user = repositories(:two)
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

    assert { repository.clone_url }
    assert { repository.user == @user }

    assert_redirected_to repositories_url
  end

  test 'should create check when repository is created' do
    sign_in(@user)

    assert_difference 'Repository::Check.count', 1 do
      post repositories_url, params: { repository: @attrs }
    end
  end

  test 'should create and refresh data when repository exists' do
    sign_in(@user)
    post repositories_url, params: { repository: @repository_exists.slice(:github_id) }

    repository = Repository.find_by @repository_exists.slice(:github_id)

    assert { repository.clone_url != @repository_exists.clone_url }

    assert_redirected_to repositories_url
  end

  test 'should not create and refresh data when repository belongs to another user' do
    sign_in(@user)
    post repositories_url, params: { repository: @repository_belongs_to_another_user.slice(:github_id) }

    repository = Repository.find_by @repository_belongs_to_another_user.slice(:github_id)

    assert { repository.clone_url == @repository_belongs_to_another_user.clone_url }

    assert_redirected_to root_url
  end

  test 'should get show when user is author' do
    sign_in(@user)
    get repository_url @repository_exists

    assert_response :success
  end

  test 'should not get show when user is not author' do
    sign_in(@user)
    get repository_url @repository_belongs_to_another_user

    assert_response :missing
  end

  test 'should not get show when user is not logged in' do
    get repository_url @repository_exists

    assert_redirected_to root_url
  end
end
