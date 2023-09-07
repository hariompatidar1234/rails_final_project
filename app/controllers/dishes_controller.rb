class DishesController < ApplicationController
  skip_before_action :check_customer
  before_action :check_owner, only: %i[create update destroy]

  def create
    dish = Dish.new(dish_params)
    if dish.save
      render json: { message: 'Dish added successfully!!', data: dish }, status: :created
    else
      render json: { errors: dish.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    if params[:page]
      dishes=Dish.page(params[:page]).per(15)
      # Dish.paginate :per_page => 2, :page => params[:page]
    else
      dishes = Dish.all
    end
    render json: dishes, status: :ok
  end

  def update
    @dish=Dish.find_by_id(params[:id])
    if @dish
      @dish.update(dish_params)
      render json: { message: 'updated successfully' }
    else
      render json: {message: 'Updation failed'}
    end
  end

  def destroy
    @dish=Dish.find_by_id(params[:id])
    if @dish
      @dish.destroy
      render json: {message: "successfully  Deleted dish"}
    else
      render json: {message: "Deletion failed"}
    end
  end

  def dishes_list_by_restaurant_id
    dishes = Dish.where(restaurant_id: params[:restaurant_id])
    render json: dishes, status: :ok
  end

  def search_dishes_by_name
    name = params[:name]
    dishes = Dish.where('name LIKE ?', "%#{name}%")
    render json: dishes
  end

  private

  def dish_params
    params.permit(:name, :description, :price, :category_id, :restaurant_id,:picture)
  end

end
