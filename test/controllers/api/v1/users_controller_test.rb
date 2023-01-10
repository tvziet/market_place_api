require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should show the user with the exists ID" do
    get api_v1_user_url(@user), as: :json
    assert_response :success

    # Test to ensure response contains the correct email
    json_response = JSON.parse(self.response.body)
    assert_equal @user.email, json_response["email"]
  end

  test "should not show the user with the not exists ID" do
    get api_v1_user_url(111), as: :json
    assert_response :not_found
  end
end

