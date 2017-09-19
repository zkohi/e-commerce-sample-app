Rails.application.routes.draw do
  root 'products#index'

  get 'mypage', to: 'users#show'

  get 'cart', to: 'orders#cart'
  post 'cart', to: 'orders#create'
  patch 'cart', to: 'orders#update'
  put 'cart', to: 'orders#update'
  get 'cart/edit', to: 'orders#edit'
  delete 'cart/line_item', to: 'orders#destroy_cart_line_item', as: 'destroy_cart_line_item'

  resources :products, only: [:show]
  resources :orders, only: [:index, :show]

  scope :backoffice do
    devise_for :admins, controllers: {
      :sessions => "admins/sessions",
    }
  end

  namespace :backoffice, path: '/backoffice' do
    resources :users, except: [:new, :create]
    resources :products
    resources :orders, except: [:new, :create, :destroy]
    resources :users, except: [:new, :create, :destroy]
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }
end
