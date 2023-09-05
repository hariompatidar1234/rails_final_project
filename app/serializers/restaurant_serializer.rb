class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :address
end
