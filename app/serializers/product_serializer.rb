# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  price      :decimal(, )      not null
#  published  :boolean          default(FALSE)
#  quantity   :integer          default(0), not null
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
class ProductSerializer < ApplicationSerializer
  attributes :title, :price, :published
  belongs_to :user
end
