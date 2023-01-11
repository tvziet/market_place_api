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
class Product < ApplicationRecord
  # Validations
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :title, presence: true

  # Associations
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :orders, through: :placements

  # Scopes
  scope :filter_by_title, ->(title) { where('lower(title) LIKE ?', "%#{title.downcase}%") }
  scope :above_or_equal_to_price, ->(price) { where('price >= ?', price) }
  scope :below_or_equal_to_price, ->(price) { where('price <= ?', price) }
  scope :recent, -> { order(updated_at: :desc) }

  def self.search(params = {})
    products = params[:product_ids].present? ? Product.where(id: params[:product_ids]) : Product.all
    products = products.filter_by_title(params[:title]) if params[:title]
    products = products.above_or_equal_to_price(params[:min_price]) if params[:min_price]
    products = products.below_or_equal_to_price(params[:max_price]) if params[:max_price]
    products.recent
  end
end
