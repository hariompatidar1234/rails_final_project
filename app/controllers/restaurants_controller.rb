class RestaurantsController < ApplicationController
  skip_before_action :check_customer
  skip_before_action :check_owner, only: :index
  before_action :set_params, only: [:show, :destroy]
  skip_before_action :verify_authenticity_token
  
  def index
    if params[:open] == 'true'
      restaurants = Restaurant.where(status: 'open')
    else
      restaurants = Restaurant.all
    end
    render json: restaurants
  end

  def show
    restaurant = @current_user.restaurants
    render json: restaurant
  end

  # def show
  #   @restaurant = Restaurant.find(params[:id])
  #   render json: {
  #     id: @restaurant.id,
  #     name: @restaurant.name,
  #     status: @restaurant.status,
  #     picture_url: @restaurant.picture.service_url
  #   }, status: :ok
  # end
  

  def create
    restaurant = @current_user.restaurants.new(restaurant_params)
    if restaurant.save
      render json: restaurant, status: :created
    else
      render json: { error: restaurant.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @restaurant
      @restaurant.destroy
      render json: { message: "Restaurant Deleted !!!" }, status: :ok
    end
  end

  def search_dishes_by_name
    name = params[:name]
    dishes = @restaurant.dishes.where('name LIKE ?', "%#{name}%")
    render json: dishes
  end
  
  def search_restaurants_by_name
    name = params[:name]
    if name.blank?
      return render json: "Restaurant name can't be blank"
    end
    restaurant = Restaurant.where("name LIKE ?", "%#{name}%")
    render json: restaurant
  end

  private

  def restaurant_params
    params.permit(:name, :status, :user_id, :picture)
  end

  def set_params
    @restaurant = @current_user.restaurants.find(params[:id])
  end
end
  

