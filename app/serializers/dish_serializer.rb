class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price,:restaurant_id,:category_id
end
