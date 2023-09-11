class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show destroy]
  # before_action :authenticate_request
  load_and_authorize_resource
  # List all categories
  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  # Show details of a specific category by name
  def show
     @category = Category.find_by_name(params[:category_name])
    render json: { error: 'Category not found by Name' }, status: :not_found unless @category
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

  private

  def category_params
    params.permit(:name)
  end
end
