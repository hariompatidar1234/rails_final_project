class CategoriesController < ApplicationController
	skip_before_action :authenticate_request
	skip_before_action :check_customer
	skip_before_action :check_owner
	before_action :set_category, only: [:show]
	skip_before_action :verify_authenticity_token
  
	# For both owners and customers: List all categories
	def index
	  categories = Category.all
	  render json: categories, status: :ok
	end
  
	# For both owners and customers: Show details of a specific category
	def show
	  if @category
		render json: @category, status: :ok
	  end
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
  
  
