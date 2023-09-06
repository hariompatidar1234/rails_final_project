class OrdersController < ApplicationController
  # require 'byebug'
  skip_before_action :check_owner
  before_action :set_order, only: %i[show destroy]
  def create
    dish_id = params[:dish_id]
    dishes = Dish.where(id: dish_id)
    order = current_user.orders.new(order_params)
    if order.save
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


  def update
    @order = current_user.orders.find_by(id: params[:id])
    if  @order.order_status == "cart"
      if @order.update(order_status: "ordered")
        render json: { message: 'Order status updated to "ordered"' }, status: :ok
      else
        render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: 'Order not found or cannot be updated' }, status: :not_found
    end
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
end
