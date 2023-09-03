Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'restaurants#index'

  resources :customers

# Routes for RestaurantsController
resources :restaurants

# Routes for DishesController
resources :dishes

# Routes for OrdersController
resources :orders
resources :categories

resources :users
post '/users_login', to: 'users#login'

# resources :restaurants
# get '/search_dishes_by_name', to: 'restaurants#search_dishes_by_name'
# get '/search_restaurants_by_name', to: 'search_restaurants_by_name'


# get '/open_restaurants', to: 'customers#open_restaurants'
   
end
