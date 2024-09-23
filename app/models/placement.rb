# == Schema Information
#
# Table name: placements
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :bigint           not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_placements_on_order_id    (order_id)
#  index_placements_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
class Placement < ApplicationRecord
  # Associations
  belongs_to :order
  belongs_to :product, inverse_of: :placements

  # Callbacks
  after_create :decrement_product_quantity!

  def decrement_product_quantity!
    product.decrement(:quantity, quantity)
  end
end
