class DishOrdersController < ApplicationController

  before_action :set_dish_order, only: [:show, :update, :destroy]

  def index
    @dish_orders = DishOrder.all
    render json: @dish_orders
  end

  def show
    render json: @dish_order
  end

  def create
    @dish_order = DishOrder.new(dish_order_params)

    if @dish_order.save
      render json: @dish_order, status: :created
    else
      render json: @dish_order.errors, status: :unprocessable_entity
    end
  end

  def update
    if @dish_order.update(dish_order_params)
      render json: @dish_order
    else
      render json: @dish_order.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @dish_order.destroy
  end

  private

  def set_dish_order
    @dish_order = DishOrder.find(params[:id])
  end

  def dish_order_params
    params.require(:dish_order).permit(:order_id, :dish_id, :order_status, :quantity, :total_amount)
  end
end
