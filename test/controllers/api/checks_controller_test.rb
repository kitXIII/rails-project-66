# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repository = repositories(:one)
  end

  test 'should handle api check post request' do
    assert_difference 'Repository::Check.count', 1 do
      post api_checks_url({ repository: { id: @repository.github_id } })
    end

    check = @repository.checks.last

    assert { check.result_success? }
    assert_response :success
  end

  test 'should not handle api check post request with wrong repository id' do
    assert_no_difference 'Repository::Check.count', 1 do
      post api_checks_url({ repository: { id: 123_456_789 } })
    end

    assert_response :missing
  end
end
