class CategoriesController < ApplicationController
  before_action :check_owner,only: %i[create,destroy]
  before_action :set_category, only: %i[show destroy]

  # For both owners and customers: List all categories
  def index
    categories = Category.all
    render json: categories, status: :ok
  end

  # For both owners and customers: Show details of a specific category
  def show
      render json: @category, status: :ok
  end

  # For owners: Create a new category
  def create
    category = Category.new(category_params)
    if category.save
      render json: { message: 'Category Created', data: category }
    else
      render json: { errors: category.errors.full_messages }
    end
  end

  def destroy
    @category.destroy
    render json: { message: 'category Deleted !!!' }, status: :ok
  end

  private

  def category_params
    params.permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Category not found' }, status: :not_found
  end
end
