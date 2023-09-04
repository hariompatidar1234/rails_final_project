class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :restaurants, dependent: :destroy

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
