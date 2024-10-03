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
class User < ApplicationRecord
  # Validations
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :password_digest, presence: true

  # Attributes
  has_secure_password
  has_one_attached :avatar

  # Associations
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy

  def avatar_url
    return '' unless avatar.attached?

    avatar.blob.url
  end
end
