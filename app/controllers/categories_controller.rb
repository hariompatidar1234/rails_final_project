class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :destroy]
  load_and_authorize_resource # Load the category and authorize actions using CanCanCan

  # List all categories
  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  # Show details of a specific category by name
  def show
    render json: @category, status: :ok
  end

  # Create a new category
  def create
    @category = Category.new(category_params) # Load a new category
    if @category.save
      render json: { message: 'Category Created', data: @category }, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Delete a category by name
  def destroy
    if @category.destroy
      render json: { message: 'Category Deleted by Name !!!' }, status: :ok
    else
      render json: { message: 'Category not found by Name' }, status: :not_found
    end
  end

  private

  def category_params
    params.permit(:name)
  end

  def set_category
    name = params[:name]
<<<<<<< HEAD
    @category = Category.find_by_name(params[:category_name])
=======
    @category = Category.find_by(name: name)
>>>>>>> Master
    render json: { error: 'Category not found by Name' }, status: :not_found unless @category
  end
end
