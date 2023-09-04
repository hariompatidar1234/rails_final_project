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
  get '/search_dishes_by_name', to: 'dishes#search_dishes_by_name'
  get '/search_restaurants_by_name', to: 'restaurants#search_restaurants_by_name'
  get '/dishes_list_by_restaurant_id', to: 'dishes#dishes_list_by_restaurant_id'

  # get '/open_restaurants', to: 'customers#open_restaurants'
end
