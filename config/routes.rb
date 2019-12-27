Rails.application.routes.draw do

  devise_for :users,  path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }, controllers: { omniauth_callbacks: 'users/omniauth' }

  resources :amazon_shipments do
    collection do
      get 'import'
      post 'import'
    end
  end

  resources :books

  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  root to: 'pages#home'
end
