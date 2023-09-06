class Order < ApplicationRecord
  belongs_to :user
  belongs_to :dish
  validates :quantity, presence: true
  validates :order_status, inclusion: { in: %w[cart ordered] }
  validates :quantity, numericality: { greater_than: 0 }
  before_save :calculate_total_amount
  before_validation :set_default_order_status

  private

  def calculate_total_amount
    self.total_amount = quantity * dish.price
  end
    #Callback method to set the default order_status to "cart"
  def set_default_order_status
    self.order_status ||= "cart"
  end

end
