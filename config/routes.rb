Rails.application.routes.draw do
  resource :customers
  # put '/customers_update', to: 'customers#update'
  resources :orders
  resources :categories
  resources :dishes
  resources :owners
  put '/owners_update',to: 'owners#update'
  resources :restaurants
  resources :users do
    resources :restaurants
  end

  resources :customers do
    resources :dishes do
      resources :orders
    end
  end

  resources :users
  post '/users_login', to: 'users#login'

  # resources :restaurants
  get '/search_dishes_by_name', to: 'dishes#search_dishes_by_name'
  get '/search_restaurants_by_name', to: 'restaurants#search_restaurants_by_name'
  get '/dishes_list_by_restaurant_id', to: 'dishes#dishes_list_by_restaurant_id'

  get '/open_restaurants', to: 'customers#open_restaurants'
end
