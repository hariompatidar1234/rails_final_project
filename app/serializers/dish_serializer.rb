class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price,:restaurant_id,:category_id, :restaurant

  def restaurant
    object.dish.restaurant.name
  end 

end
