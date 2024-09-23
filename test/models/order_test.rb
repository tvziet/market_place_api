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
require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  setup do
    @order = orders(:one)
    @product1 = products(:one)
    @product2 = products(:two)
  end

  test 'should set total' do
    @order.placements = [
      Placement.new(product_id: @product1.id, quantity: 2),
      Placement.new(product_id: @product2.id, quantity: 2)
    ]
    @order.set_total!
    expected_total = ((@product1.price * 2) + (@product2.price * 2))

    assert_equal expected_total, @order.total
  end

  test 'an order should command not too much product than available' do
    @order.placements << Placement.new(product_id: @product1.id, quantity: 1 + @product1.quantity)
    assert_not @order.valid?
  end
end
