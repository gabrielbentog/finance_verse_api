Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users

      post 'authenticate', to: 'authentication#authenticate'
    end
  end
end
