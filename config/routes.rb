Rails.application.routes.draw do
  namespace :accounts do
    resources :indexes, only: [:update, :create]
    resources :transfers, only: :update
    resources :deposits, only: :create
    resources :balances, only: :create
  end
end
