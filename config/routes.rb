Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: [:show]
  resources :orders, only: [:index, :show, :create]

  scope :admin do
    devise_for :admins
  end

  namespace :admin, path: '/admin' do
#    resources :users, except: [:new, :create]
    resources :products
    resources :orders, except: [:new, :create, :destroy]
    resources :users, except: [:new, :create, :destroy]
  end

  devise_for :users
end
