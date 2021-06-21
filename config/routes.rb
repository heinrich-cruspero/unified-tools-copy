# frozen_string_literal: true

# rubocop:disable  Metrics/BlockLength
Rails.application.routes.draw do
  resources :book_field_mappings
  resources :book_export_templates do
    member do
      get 'use'
      post 'use'
    end
  end
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
    member do
      get 'details'
      get 'detail_guides'
      get 'amazon_orders'
      get 'all_history'
      get 'history_chart'
      get 'sales_rank_history'
      get 'amazon_prices_history'
    end
    collection do
      get 'link_oe_isbn'
      post 'link_oe_isbn_import'

      get 'add_isbn'
      post 'add_isbn_import'
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
# rubocop:enable  Metrics/BlockLength
