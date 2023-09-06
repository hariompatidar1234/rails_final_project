class OrdersController < ApplicationController
  # require 'byebug'
  skip_before_action :check_owner
  before_action :set_order, only: %i[show destroy]
  # skip_before_action :verify_authenticity_token

  # Create a new order
  def create
    # restaurant = Restaurant.find_by(id: params[:order][:restaurant_id])
    # dishes = Dish.find_by(id: params[:order][:dish_ids])
    dish_id = params[:dish_id]
    dishes = Dish.where(id: dish_id)
    total_amount = calculate_total_amount(dishes)
    order = current_user.orders.new(order_params.merge(total_amount: total_amount))
    if order.save
      # order.dishes << dishes
      # order.create(dishes: dishes)
      # byebug
      render json: { message: 'Order created successfully', data: order }, status: :created
    else

      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # List all orders
  def index
    orders = current_user.orders
    return render json: { message: 'No orders found' } unless orders.present?

    render json: orders, status: :ok
  end

  # Show a specific order
  def show
    render json: @order, status: :ok if @order.present?
  end

  # Delete an order
  def destroy
    return unless @order

    @order.destroy
    render json: { message: 'Order deleted' }, status: :ok
  end

  private

  # Set the @order instance variable based on the order ID
  def set_order
    @order = current_user.orders.find_by(id: params[:id])
    return if @order

    render json: { message: 'Order not found' }, status: :not_found
  end

  # Define the strong parameters for creating an order
  def order_params
    params.permit(
      :order_status,
      :quantity,
      # :user_id,
      :dish_id
    )
  end

  # Calculate the total amount based on selected dishes
  def calculate_total_amount(dishes)
    # dishes.sum(&:price)
    total_amount = 0
    dishes.each do |dish|
      total_amount += dish.price
    end
    total_amount
  end
end
