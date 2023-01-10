# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "user with a valid email should be valid" do
    user = User.new(email: "test@test.example",
                    password_digest: "test")
    assert user.valid?
  end

  test "user with a invalid email should be invalid" do
    user = User.new(email: "test$test.example")
    assert user.invalid?
  end

  test "user with taken email should be invalid" do
    user = users(:one)
    other_user = User.new(email: user.email, password_digest: "other_user_test")
    assert other_user.invalid?
  end

  test "destroy user should destroy linked product" do
    assert_difference("Product.count", -1) do
      users(:one).destroy
    end
  end
end
