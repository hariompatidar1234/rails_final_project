class RestaurantsController < ApplicationController
  skip_before_action :check_customer
  skip_before_action :check_owner

  def index
    restaurants = if params[:open] == 'true'
      Restaurant.where(status: 'open')
    else
      Restaurant.all
    end
    render json: restaurants
  end

  def show
    @restaurant=Restaurant.find_by_id(params[:id])
    render json: @restaurant
  end

  def create
    restaurant = @current_user.restaurants.new(restaurant_params)
    if restaurant.save
      render json: restaurant, status: :created
    else
      render json: { error: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def update
    @restaurant=Restaurant.find_by_id(params[:id])
    @restaurant.update(restaurant_params)
    render json: { message: 'updated successfully' }
  end

  def destroy
    @restaurant=Restaurant.find_by_id(params[:id])
    @restaurant.destroy
    render json: {message: 'Deleted successfully'}
  end


  def search_restaurants_by_name
    name = params[:name]
    return render json: "Restaurant name can't be blank" if name.blank?

    restaurant = Restaurant.where('name LIKE ?', "%#{name}%")
    render json: restaurant
  end

  private

  def restaurant_params
    params.permit(:name, :status, :address, :user_id, :picture)
  end
end
