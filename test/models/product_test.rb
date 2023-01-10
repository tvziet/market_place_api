# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  price      :decimal(, )      not null
#  published  :boolean          default(FALSE)
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product with negative price should be invalid" do
    product = products(:one)
    product.price = -1
    assert product.invalid?
  end

  test "product has null price should be invalid" do
    product = products(:one)
    product.price = nil
    assert product.invalid?
  end

  test "product has null title should be invalid" do
    product = products(:one)
    product.title = nil
    assert product.invalid?
  end

  test "product does not reference to an user should be invalid" do
    product = products(:one)
    product.user_id = nil
    assert product.invalid?
  end
end
