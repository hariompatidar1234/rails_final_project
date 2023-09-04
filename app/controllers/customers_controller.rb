class CustomersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  skip_before_action :check_customer, only: [:create]
  skip_before_action :check_owner
  skip_before_action :verify_authenticity_token

  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: { message: 'Customer Created!!!', data: customer }
    else
      render json: customer.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    current_user.update(customer_params)
    render json: { message: 'Customer updated' }
  end

  def destroy
    if current_user.destroy
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
