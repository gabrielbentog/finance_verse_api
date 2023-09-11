Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users
      resources :transactions
      resources :transaction_types
      resources :categories

      post 'authenticate', to: 'authentication#authenticate'
    end
  end
end
