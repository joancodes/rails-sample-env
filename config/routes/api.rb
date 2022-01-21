Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    namespace :v1 do
      post 'auth', to: 'sessions#create'
    end
  end
end
