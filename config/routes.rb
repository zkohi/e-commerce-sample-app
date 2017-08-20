Rails.application.routes.draw do
  root 'products#index'

  resources :products, only: [:show]

  scope :admin do
    devise_for :admins
  end

  namespace :admin, path: '/admin' do
    resources :products
  end

  devise_for :users
end
