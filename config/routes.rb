Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#welcome'
  namespace :api do
    namespace :v1 do
      resources :stations, only: [:index, :show]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
    end
  end
end
