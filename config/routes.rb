# frozen_string_literal: true

Rails.application.routes.draw do
  resources :amazon_shipments do
    collection do
      get 'import'
      post 'import'
    end
  end

  resources :books, only: [:index]

  devise_for :users,
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'books#index'
end
