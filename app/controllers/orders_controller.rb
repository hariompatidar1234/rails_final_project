class OrdersController < ApplicationController
  load_and_authorize_resource

  def index
    orders = Order.all
    render json: orders
  end

  def show
    order=Order.find_by_id(params[:id])
    render json: order
  end

  def create
    @order = Order.new(order_params)
    if @order.save
    render json: { message: 'order created by customer' }, status: :ok
    else
      render json: {message: 'ordered failed'}
    end
  end

  def order_params
    params.require(:order).permit(:user_id)
  end
end
