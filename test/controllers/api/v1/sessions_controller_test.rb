require 'test_helper'

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test 'should get JWT token' do
    post api_v1_login_url, params: { user: { email: @user.email, password: 'p@ssw0rd' } }, as: :json
    assert_response :success

    json_response = response.parsed_body
    assert_not_nil json_response['token']
  end

  test 'should not get JWT token' do
    post api_v1_login_url, params: { user: { email: @user.email, password: 'not_p@ssw0rd' } }, as: :json
    assert_response :unauthorized
  end
end
