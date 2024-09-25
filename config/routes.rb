Rails.application.routes.draw do
  get '/api-docs', to: 'api_docs#index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show update destroy]
      resources :products
      resources :orders, only: %i[index show create]
      post 'login', to: 'sessions#create'
      post 'register', to: 'users#create'
    end
  end
end
