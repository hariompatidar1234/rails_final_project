class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :update, :destroy]
  load_and_authorize_resource # Load the restaurant and authorize actions using CanCanCan

  def index
    page_number = params[:page] || 1
    per_page = params[:per_page] || 10  # You can adjust the number of items per page

    # Filter restaurants based on the 'open' status if 'open' param is provided
    restaurants = if params[:open] == 'true'
      Restaurant.where(status: 'open').page(page_number).per(per_page)
    else
      Restaurant.page(page_number).per(per_page)
    end

    # Render the paginated restaurants as JSON
    render json: restaurants
  end

  def show
    render json: @restaurant
  end

  def create
    restaurant = current_user.restaurants.new(restaurant_params)
    if restaurant.save
      render json: restaurant, status: :created
    else
      render json: { errors: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      render json: { message: 'Updated successfully' }
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @restaurant.destroy
      render json: { message: 'Deleted successfully' }
    else
      render json: { errors: @restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def restaurant_params
    params.permit(:name, :status, :address, :picture)
  end

  def set_restaurant
    # byebug
  @restaurant = Restaurant.find_by_name(params[:restaurant_name])
  end
end
