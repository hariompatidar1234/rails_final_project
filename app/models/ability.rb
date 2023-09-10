class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.type=="Owner"
      # Abilities for owners
      can :manage,[Owner]
      can :manage, [Restaurant, Category, Dish] 
      can :index, [Restaurant, Category, Dish] 
      can :show, [Restaurant, Category, Dish]
      can :search, [Dish] # Search for dishes
      # can :create, Restaurant
      can :destroy, Category

    else user.type=="Customer"
      # Abilities for customers
      can :create, Order # Create an order
      can :read, Order, user_id: user.id # View their own orders
      can :update, Order, user_id: user.id, order_status: 'cart' 
      can :destroy, Order, user_id: user.id, order_status: 'cart' 
      
      can :index, [Restaurant, Dish]
      can :search, [Dish] 
      can :read, Category 
      can :see_open, Restaurant, status: 'open' # See open restaurants
    end
  end
end
