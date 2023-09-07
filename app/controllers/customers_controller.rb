class CustomersController < ApplicationController
  skip_before_action :authenticate_request, only: :create

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: { message: 'Customer Created!!!', data: customer }, status: :created
    else
      render json: { errors: customer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: @current_user
  end

  def update
    if @current_user.update(customer_params)
      render json: { message: 'Customer updated' }
    else
      render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @current_user.destroy
      render json: { message: 'Customer deleted' }, status: :no_content
    else
      render json: { message: 'Customer deletion failed' }
    end
  end

  def open_restaurants
    restaurants = Restaurant.where(status: 'open')
    render json: restaurants
  end

  private

  def customer_params
    params.permit(:name, :email, :password)
  end
end
