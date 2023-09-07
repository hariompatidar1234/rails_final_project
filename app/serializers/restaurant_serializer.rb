class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :address,:picture_url
  def picture_url
    Rails.application.routes.url_helpers.rails_blob_path(object.picture, only_path: true) if object.picture.attached?
  end
end
