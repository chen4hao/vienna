Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users
    resources :services
    resources :rooms
    resources :room_calendars do
      get  :calendar, on: :collection
      get  :monthly, on: :collection
      get  :weekly, on: :collection
      member do
        post :to_dealday
        post :to_holiday
        post :to_hotday
        post :to_weekday
      end
    end

  end

  resources :dashboard

  resources :clients do
    get :search, on: :collection
  end

  resources :orders do
    get :search_clients, on: :collection
    get :list_services, on: :collection
    get :list_rooms, on: :collection
    post :add_to_cart, on: :member
    get :daily, on: :collection
  end

  resources :statistics do
    get :daily, on: :collection
    get :weekly, on: :collection
    get :monthly, on: :collection
    get :yearly, on: :collection
  end

  resources :print do
    get :orders, on: :collection
    get :abstract, on: :collection
    get :clients, on: :collection
    get :export, on: :collection
  end


  # root 'dashboard#index'
  root 'admin/room_calendars#weekly'

end
