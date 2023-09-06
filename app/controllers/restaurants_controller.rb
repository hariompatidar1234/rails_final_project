class RestaurantsController < ApplicationController
  skip_before_action :check_customer
  skip_before_action :check_owner, only: %i[index create]
  before_action :set_params, only: %i[show destroy]
  # skip_before_action :verify_authenticity_token

  def index
    restaurants = if params[:open] == 'true'
                    Restaurant.where(status: 'open')
                  else
                    Restaurant.all
                  end
    render json: restaurants
  end

  def show
    restaurant = @current_user.restaurants
    render json: restaurant
  end

  def create
    restaurant = @current_user.restaurants.new(restaurant_params)
    if restaurant.save
      render json: restaurant, status: :created
    else
      render json: { error: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @restaurant

    @restaurant.destroy
    render json: { message: 'Restaurant Deleted !!!' }, status: :ok
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

  def set_params
    @restaurant = @current_user.restaurants.find(params[:id])
  end
end
