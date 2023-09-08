class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :destroy, :update]
  load_and_authorize_resource # Load the order and authorize actions using CanCanCan

  def create
    dish_ids = params[:dish_ids]
    restaurant_id = params[:restaurant_id]
<<<<<<< HEAD
=======

    # Check if all selected dishes belong to the same restaurant
>>>>>>> Master
    restaurant = Restaurant.find_by(id: restaurant_id)
    if restaurant.nil?
      return render json: { message: 'Restaurant not found' }, status: :unprocessable_entity
    end

    dishes = Dish.where(id: dish_ids)
    if dishes.empty?
      return render json: { message: 'No valid dishes found for the order' }, status: :unprocessable_entity
    elsif dishes.pluck(:restaurant_id).uniq.count > 1
      return render json: { message: 'Dishes belong to different restaurants' }, status: :unprocessable_entity
    elsif dishes.first.restaurant_id != restaurant_id.to_i
      return render json: { message: 'Dishes do not belong to the specified restaurant' }, status: :unprocessable_entity
    end

    order = current_user.orders.new(order_params)

    if order.save
      order.dishes << dishes
      render json: { message: 'Order created successfully', data: order }, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
    end
  end

 # List all orders
def index
  page_number = params[:page] || 1
  per_page = params[:per_page] || 10  # You can adjust the number of items per page

  # Retrieve orders for the current user and paginate them
  orders = current_user.orders.page(page_number).per(per_page)

  if orders.empty?
    render json: { message: 'No orders found' }
  else
    render json: orders, each_serializer: OrderSerializer, status: :ok
  end
end


  def update
    if @order.order_status == 'cart'
      if @order.update(order_status: 'ordered')
        render json: { message: 'Order status updated to ordered' }, status: :ok
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
      dish_ids: []
    )
  end
end




# class OrdersController < ApplicationController
#   skip_before_action :check_owner
#   before_action :set_order, only: %i[show destroy]

#   def create
#     dish_id = params[:dish_id]
#     dishes = Dish.where(id: dish_id)
#     order = current_user.orders.new(order_params)
#     if order.save
#       render json: { message: 'Order created successfully', data: order }, status: :created
#     else

#       render json: { errors: order.errors.full_messages }, status: :unprocessable_entity
#     end
#   end

#   # List all orders
#   def index
#     orders = current_user.orders
#     return render json: { message: 'No orders found' } unless orders.present?

#     render json: orders, status: :ok
#   end


#   def update
#     @order = current_user.orders.find_by(id: params[:id])
#     if  @order.order_status == "cart"
#       if @order.update(order_status: "ordered")
#         render json: { message: 'Order status updated to ordered' }, status: :ok
#       else
#         render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
#       end
#     else
#       render json: { message: 'Order not found or cannot be updated' }, status: :not_found
#     end
#   end



#   # Show a specific order
#   def show
#     render json: @order, status: :ok if @order.present?
#   end

#   # Delete an order
#   def destroy
#     @order.destroy
#     render json: { message: 'Order deleted' }, status: :ok
#   end

#   private

#   # Set the @order instance variable based on the order ID
#   def set_order
#     @order = current_user.orders.find_by(id: params[:id])
#     return if @order

#     render json: { message: 'Order not found' }, status: :not_found
#   end

#   # Define the strong parameters for creating an order
#   def order_params
#     params.permit(
#       :order_status,
#       :quantity,
#       :dish_id
#     )
#   end
# end
