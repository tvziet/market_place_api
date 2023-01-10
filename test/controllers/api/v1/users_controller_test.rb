require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  # Show action
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

  # Create action
  test "should create user" do
    assert_difference("User.count") do
      post api_v1_users_url, params: { user: { email: "test@test.example",
                                              password: "test" } }, as: :json
    end
    assert_response :created
  end

  test "should not create user with taken email" do
    assert_no_difference("User.count") do
      post api_v1_users_url, params: { user: { email: @user.email,
                                              password: "test" } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  # Update action
  test "should update user" do
    patch api_v1_user_url(@user), params: { user: { email: "new@new.example",
                                                    password: "new"} }
    assert_response :ok
  end

  test "should not update user when invalid params are sent" do
    patch api_v1_user_url(@user), params: { user: { email: "new$new.example",
                                                    password: "new"} }
    assert_response :unprocessable_entity                                              
  end
end

