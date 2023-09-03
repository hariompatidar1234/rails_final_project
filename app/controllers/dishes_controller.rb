class DishesController < ApplicationController
    skip_before_action :check_custom er
    skip_before_action :verify_authenticity_token
  
    def create
      dish = Dish.new(dish_params)
      if dish.save
        render json: { message: 'Dish added successfully!!', data: dish }, status: :created
      else
        render json: { errors: dish.errors.full_messages }, status: :unprocessable_entity
      end
    end
    def index
      dishes = Dish.all
      render json: dishes, status: :ok
    end

    def dishes_list_by_restaurant_id
      dishes = Dish.where(restaurant_id: params[:restaurant_id])
      render json: dishes, status: :ok
    end
  
    private
  
    def dish_params
      params.permit(:name, :description, :price, :category_id, :restaurant_id)
    end
end

