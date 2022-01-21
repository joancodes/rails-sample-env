Rails.application.routes.draw do
  resources :companies do
    resources :answers
    resources :surveys
    resources :questions
    resources :customers
    resources :users
  end

  resources :answers
  resources :surveys
  resources :questions
  resources :customers
  resources :users

  root to: 'companies#index'
end
