Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    namespace :v1 do
      post 'auth', to: 'sessions#create'
      resources :users, only: [:index, :show]
    end
  end
end
