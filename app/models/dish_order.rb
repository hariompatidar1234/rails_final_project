class DishOrder < ApplicationRecord
  belongs_to :dish
  belongs_to :order

  validates :quantity, presence: true
  validates :order_status, inclusion: { in: %w[cart ordered] }
  validates :quantity, numericality: { greater_than: 0 }
  x
  before_save :calculate_total_amount
  before_validation :set_default_order_status
  # validate :same_restaurant

  private

  def calculate_total_amount
    self.total_amount = quantity * dish.price
  end


  def set_default_order_status
    self.order_status ||= "cart"
  end

  
  # def same_restaurant
  #   unless order.user_id == dish.restaurant.user_id
  #     errors.add(:base, "Dish and order must belong to the same restaurant")
  #   end
  # end

end
