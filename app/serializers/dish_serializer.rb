class DishSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :restaurant, :category, :picture_url

  def restaurant
    object.restaurant.name
  end

  def category
    object.category.name
  end

  def picture_url
    Rails.application.routes.url_helpers.rails_blob_path(object.picture, only_path: true) if object.picture.attached?
  end
end
