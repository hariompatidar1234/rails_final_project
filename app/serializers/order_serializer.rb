class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_status, :quantity, :total_amount, :user_id, :restaurant
  
  def restaurant
    object.dish.restaurant.name
  end
  
  def restaurant_address
    object.dish.restaurant.address
  end
end
