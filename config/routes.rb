Rails.application.routes.draw do
  resources :companies do
    resources :answers
    resources :surveys
    resources :questions
    resources :customers
    resources :users
    resources :gcra_settings
  end

  resources :answers
  resources :surveys
  resources :questions
  resources :customers
  resources :users do
    member do
      get :otp
      post :verify_totp
    end
  end
  resources :gcra_settings

  root to: 'companies#index'
end
