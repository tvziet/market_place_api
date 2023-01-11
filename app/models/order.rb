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
end
