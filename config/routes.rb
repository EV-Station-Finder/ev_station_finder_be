Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#welcome'
  namespace :api do
    namespace :v1 do
      resources :stations, only: [:index, :show]
      resources :users, only: [:create]
      resource :users, only: [:show, :destroy, :update]
      resources :sessions, only: [:create]
      resources :dashboard, only: [:index]
      resources :favorite_stations, only: [:index, :create]
      get '/authorize', to: 'sessions#authorize'
    end
  end
end
