class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :restaurants, dependent: :destroy
  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true,
  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Invalid email id!!!!' }
end
