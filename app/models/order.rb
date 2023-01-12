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
class Order < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements

  # Callbacks
  before_validation :set_total!

  def set_total!
    self.total = products.map(&:price).sum
  end

  # Add quanity for the placements
  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    # Format of product_ids_and_quantities like:
    # [{product_id: 1, quantity: 2}, {product_id: 2, quantity: 3}]
    product_ids_and_quantities.each do |product_id_and_quantity|
      placement = placements.build(product_id: product_id_and_quantity[:product_id],
                                    quanity: product_id_and_quantity[:quanity])
      yield placement if block_given?
    end
  end
end
