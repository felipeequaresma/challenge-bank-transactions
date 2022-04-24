Rails.application.routes.draw do
  root to: 'home#index'

  devise_for :users,
    path: 'accounts',
    path_names: {
      sign_in: 'authentication',
      registration: 'create',
    }, 
    skip: [:password],
    controllers: {
      registrations: 'users/registrations'
    }

  namespace :accounts do
    scope :transfer do
      get 'new', to: 'transfer#new', as: :new_transfer
      put 'update', to: 'transfer#update', as: :update_transfer
    end
    scope :withdrawal do 
      get 'new', to: 'withdrawal#new', as: :new_withdrawal
      put 'update', to: 'withdrawal#update', as: :update_withdrawal
    end
    scope :deposit do 
      get 'new', to: 'deposit#new', as: :new_deposit
      put 'update', to: 'deposit#update', as: :update_deposit
    end
    scope :balance do 
      get 'show', to: 'balance#show', as: :show_deposit
    end
  end
end
