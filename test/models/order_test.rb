# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  total      :decimal(, )      default(0.0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:one)
    @product1 = products(:one)
    @product2 = products(:two)
  end

  test "should set total" do
    order = Order.new(user_id: @order.user_id)
    order.products << @product1
    order.products << @product2
    order.save

    assert_equal (@product1.price + @product2.price), order.total
  end

  test "an order should command not too much product than available" do
    @order.placements << Placement.new(product_id: @product1.id, quantity: (1 + @product.quantity))
    assert_not @order.valid?
  end
end
