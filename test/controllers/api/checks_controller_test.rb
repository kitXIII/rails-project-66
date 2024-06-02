# frozen_string_literal: true

require 'test_helper'

class Api::ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @repo_web_hook_data = {}
  end

  test 'should create check' do
    post api_cehcks_url @repo_web_hook_data

    assert_response :success
  end
end
