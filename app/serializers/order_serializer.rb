class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_status, :quantity, :total_amount, :user_id, :restaurant_id, :restaurant


  def restaurant
    object.dish.restaurant.name
  end 

end
