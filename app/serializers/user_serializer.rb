# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class UserSerializer < ApplicationSerializer
  # Attributes
  attributes :email

  # Associations
  has_many :products

  # Caching serializer
  cache_options enabled: true, cache_length: 12.hours
end
