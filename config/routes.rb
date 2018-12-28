Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users
    resources :services
    resources :rooms
    resources :room_calendars do
      get  :calendar, on: :collection
      member do
        post :to_dealday
        post :to_holiday
        post :to_hotday
        post :to_weekday
      end
    end

  end

  resources :dashboard

  root 'dashboard#index'
end
