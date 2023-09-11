Rails.application.routes.draw do
  resources :categories, param: :category_name, only: %i[index show create destroy] do
  end
  resources :restaurants, param: :restaurant_name, only: %i[index show create update destroy] do
    get 'page/:page_number', action: :index, on: :collection
  end
  resources :dishes, only: %i[index show create update destroy] do
     get 'page/:page_number', action: :index, on: :collection
  end
  resources :owners, param: :owner_name, only: %i[index show create update destroy] do
  end
  resource :customers, only: %i[index show create update destroy] do
  end

  resources :dish_orders, only: %i[index show create update destroy] do
  end

  resources :orders, only: %i[index show create] do
  end
  get 'restaurants/open', to: 'restaurants#open_restaurants'
  resources :users
  post '/users_login', to: 'users#login'
end
