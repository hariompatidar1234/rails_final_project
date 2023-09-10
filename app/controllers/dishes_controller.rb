class DishesController < ApplicationController
  before_action :set_dish, only: [:update, :destroy]
  load_and_authorize_resource # Load the dish and authorize actions using CanCanCan

  def create
    @dish = Dish.new(dish_params) # Load a new dish
    if @dish.save
      render json: { message: 'Dish added successfully!', data: @dish }, status: :created
    else
      render json: { errors: @dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    page_number = params[:page] || 1
    per_page = params[:per_page] || 15 
    dishes = Dish.page(page_number).per(per_page)
    dishes = Dish.page(page_number).per(per_page)
    render json: dishes, status: :ok
  end

  def update
    if @dish.update(dish_params)
      render json: { message: 'Dish updated successfully!' }
    else
      render json: { message: 'Dish update failed' }
    end
  end

  def destroy
    if @dish.destroy
      render json: { message: 'Dish successfully deleted' }
    else
      render json: { message: 'Dish deletion failed' }
    end
  end

  def search_dishes_by_name
    name = params[:name]
    dishes = Dish.where('name LIKE ?', "%#{name}%")
    render json: dishes
  end

  private

  def dish_params
    params.permit(:name, :description, :price, :category_id, :restaurant_id, :picture)
  end

  def set_dish
    @dish = Dish.find_by_id(params[:id])
    render json: { message: 'Dish not found' }, status: :not_found unless @dish
  end
end
