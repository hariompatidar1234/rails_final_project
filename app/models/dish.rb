class Dish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_many :orders, dependent: :destroy
  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
