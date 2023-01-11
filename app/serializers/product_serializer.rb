class ProductSerializer < ApplicationSerializer
  attributes :title, :price, :published
  belongs_to :user
end
