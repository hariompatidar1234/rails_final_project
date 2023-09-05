class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :restaurant, :category

  def restaurant
    object.restaurant.name
  end

  def category
    object.category.name
  end
end
