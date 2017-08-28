Rails.application.routes.draw do
  root 'products#index'

  get 'mypage', to: 'users#show'

  resources :products, only: [:show]
  resources :line_items, only: [:destroy]
  resources :orders, only: [:index, :show, :create]
  resource :cart, only: [:show, :edit, :update]

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
