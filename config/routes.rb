Rails.application.routes.draw do
  resources :categories,param: :category_name,only:  [:index, :show, :create,:destroy] do
  end
  resources :restaurants, param: :restaurant_name, only: [:index, :show, :create, :update, :destroy] do
  end
  resources :dishes, only: [:index, :show, :create, :update, :destroy] do
  end
  resources :owners,param: :owner_name, only: [:index, :show, :create, :update, :destroy] do
  end
  resources :customers, only: [:index, :show, :create, :update, :destroy] do
  end
 
  resources :dish_orders, only: [:index, :show, :create, :update, :destroy]
  resources :orders, only: [:index, :show, :createy] do
  end
  get 'restaurants/open', to: 'restaurants#open_restaurants'
  resources :users
  post '/users_login', to: 'users#login'

end
