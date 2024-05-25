# frozen_string_literal: true

require 'test_helper'

class Web::Repositories::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)

    @repository = repositories(:one)
    @repository_check = repository_checks(:one)

    @repository_belongs_to_another_user = repositories(:two)
    @repository_check_belongs_to_another_user = repository_checks(:two)
  end

  test 'should get show when user is author' do
    sign_in(@user)
    get repository_check_url @repository, @repository_check

    assert_response :success
  end

  test 'should not get show when user is not author' do
    sign_in(@user)
    get repository_check_url @repository_belongs_to_another_user, @repository_check_belongs_to_another_user

    assert_redirected_to root_url
  end

  test 'should not get show when user is not logged in' do
    get repository_check_url @repository, @repository_check

    assert_redirected_to root_url
  end

  test 'should create post when user is author of repository' do
    sign_in(@user)

    assert_difference 'Repository::Check.count', 1 do
      post repository_checks_url @repository
    end

    assert_redirected_to repository_url @repository
  end

  test 'should not create post when user is not author of repository' do
    sign_in(@user)

    assert_no_difference 'Repository::Check.count' do
      post repository_checks_url @repository_belongs_to_another_user
    end

    assert_redirected_to root_url
  end

  test 'should not create post when user is not logged in' do
    assert_no_difference 'Repository::Check.count' do
      post repository_checks_url @repository_belongs_to_another_user
    end

    assert_redirected_to root_url
  end
end
