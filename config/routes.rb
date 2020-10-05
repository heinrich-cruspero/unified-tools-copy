# frozen_string_literal: true

Rails.application.routes.draw do
  resources :amazon_shipments do
    collection do
      get 'indaba_skus'
      get 'combine'
      get 'import'
      post 'import'
      get 'delete_skus'
      post 'delete_skus'
      post 'export'
      get 'export'

      post 'index'
      get 'index'
      post 'combine'
      post 'indaba_skus'
    end
  end

  resources :books, only: %i[index details] do
    collection do
      get 'details/:id', to: 'books#details', as: :details
    end
  end

  resources :amazon_orders, only: %i[index show] do
    collection do
      get 'order_associated_items'
      post 'export'
      get 'export'
    end
  end

  resources :amazon_order_items, only: [:index]

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'books#index'
end
