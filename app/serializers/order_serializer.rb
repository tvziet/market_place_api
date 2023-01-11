class OrderSerializer < ApplicationSerializer
  belongs_to :user
  has_many :products
end
