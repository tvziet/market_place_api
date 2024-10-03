# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  avatar          :string
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

  attribute :avatar_url

  # Associations
  has_many :products

  # Caching serializer
  cache_options enabled: true, cache_length: 12.hours
end
