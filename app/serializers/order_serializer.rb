class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_status, :quantity, :total_amount,:user_id,:restaurant_id
end
