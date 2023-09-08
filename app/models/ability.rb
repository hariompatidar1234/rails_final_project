class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    # if User.Owner?
    if 'Owner' == user.type
      # # Abilities for owners
      can :create ,[Owner]
      can :manage, [Restaurant, Category, Dish] # Create, update, and destroy restaurants, categories, and dishes
      can :index, [Restaurant, Category, Dish] # View lists of restaurants, categories, and dishes
      can :search, [Dish] # Search for dishes
    else 'Customer' == user.type
      # Abilities for customers
      can :create, Order # Create an order
      can :read, Order, user_id: user.id # View their own orders
      can :update, Order, user_id: user.id, order_status: 'cart' # Update their own orders if in the cart state
      can :destroy, Order, user_id: user.id, order_status: 'cart' # Delete their own orders if in the cart state
      can :index, [Restaurant, Dish] # View lists of restaurants and dishes
      can :search, [Dish] # Search for dishes
      can :read, Category # View categories
      can :see_open, Restaurant, status: 'open' # See open restaurants
    end
  end
end
