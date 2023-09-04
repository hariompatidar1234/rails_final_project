class Order < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  belongs_to :restaurant

  validates :order_status, presence: true, inclusion: { in: %w[cart ordered] }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  before_save :calculate_total_amount

  private

  def calculate_total_amount
    self.total_amount = quantity * dish.price
  end
end
