class UserSerializer < ApplicationSerializer
  attributes :email
  has_many :products
end
