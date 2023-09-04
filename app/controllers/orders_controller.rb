class OrdersController < ApplicationController
  skip_before_action :check_owner
  before_action :set_order, only: %i[show destroy]
  skip_before_action :verify_authenticity_token

  # Create a new order
  def create
    restaurant = Restaurant.find_by(id: params[:order][:restaurant_id])
    dishes = Dish.where(id: params[:order][:dish_ids])
    total_amount = calculate_total_amount(dishes)

    order = current_user.orders.new(order_params.merge(total_amount: total_amount,restaurant: restaurant) )

    if order.save
      order.order_items.create(dishes: dishes)
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
    params.require(:order).permit(
      :order_status,
      :quantity,
      # :user_id,
      :restaurant_id,
      dish_ids: []
    )
  end

  # Calculate the total amount based on selected dishes
  def calculate_total_amount(dishes)
    dishes.sum(&:price)
  end
end
