class OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_status, :quantity, :total_amount, :user_id

  belongs_to :user
  belongs_to :dish
end
