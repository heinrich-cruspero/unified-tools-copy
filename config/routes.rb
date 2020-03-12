# frozen_string_literal: true

Rails.application.routes.draw do
  resources :amazon_shipments do
    collection do
      get 'import'
      post 'import'
      get 'indaba_skus'
      get 'delete_skus'
      post 'delete_skus'
    end
  end

  resources :books, only: [:index]

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'books#index'
end
