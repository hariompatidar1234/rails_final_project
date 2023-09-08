Rails.application.routes.draw do
  resource :customers
  # put '/customers_update', to: 'customers#update'
  resources :categories,param: :category_name,only:  [:index, :show, :create,:destroy] do
    # Add custom routes specific to categories if needed
  end

  # Restaurants
  resources :restaurants, param: :restaurant_name, only: [:index, :show, :create, :update, :destroy] do
    # Add custom routes specific to restaurants if needed
  end

  # Dishes
  resources :dishes, only: [:index, :show, :create, :update, :destroy] do
    # Add custom routes specific to dishes if needed
  end

  # Owners (assuming you have a separate controller for owners)
  resources :owners,param: :owner_name, only: [:index, :show, :create, :update, :destroy] do
    # Add custom routes specific to owners if needed
  end

  # Customers (assuming you have a separate controller for customers)
  resources :customers, only: [:index, :show, :create, :update, :destroy] do
    # Add custom routes specific to customers if needed
  end

  # Orders
  resources :orders, only: [:index, :show, :create, :update, :destroy] do
    # Add custom routes specific to orders if needed
  end

  # Additional custom routes can be added as needed

  # For example, to define a custom route for open restaurants
  get 'restaurants/open', to: 'restaurants#open_restaurants'


  resources :users
  post '/users_login', to: 'users#login'

  # resources :restaurants
  get '/search_dishes_by_name', to: 'dishes#search_dishes_by_name'
  get '/search_restaurants_by_name', to: 'restaurants#search_restaurants_by_name'
  get '/dishes_list_by_restaurant_id', to: 'dishes#dishes_list_by_restaurant_id'
  get '/open_restaurants', to: 'customers#open_restaurants'


end
