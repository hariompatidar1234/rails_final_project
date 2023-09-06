class Order < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  validates :order_status, :quantity, presence: true
  validates :order_status, inclusion: { in: %w[cart ordered] }
  validates :quantity, numericality: { greater_than: 0 }
  before_save :calculate_total_amount

  private

  def calculate_total_amount
    self.total_amount = quantity * dish.price
  end
end
