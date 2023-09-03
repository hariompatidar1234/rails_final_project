class User < ApplicationRecord
    has_many :orders
    has_many :restaurants
    
    validates :name, :email, :password,presence: true
    validates :email, uniqueness: true
    validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
end
