class Dish < ApplicationRecord
  belongs_to :restaurant
  belongs_to :category
  has_one_attached :picture
  has_many :orderdishes
  has_many :orders,through: :orderdishes
  validates :name, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
end
