Rails.application.routes.draw do
  get 'mypage', to: 'users#show'

  resource :cart, controller: 'orders', only: [:create, :update, :edit]
  get 'cart', to: 'orders#cart'
  delete 'cart/line_items', to: 'orders#destroy_cart_line_item', as: 'destroy_cart_line_item'

  resources :products, only: [:index, :show]
  resources :orders, only: [:index, :show]
  resources :coupons, except: [:show]
  resources :user_points, only: [:index]

  root 'diaries#index'
  resources :diaries, except: [:index] do
    resources :comments, only: [:create, :destroy], controller: 'diary_comments'
    resources :evaluations, only: [:create, :destroy], controller: 'diary_evaluations'
  end


  scope :backoffice do
    devise_for :admins, controllers: {
      :sessions => "admins/sessions",
    }
  end

  namespace :backoffice, path: '/backoffice' do
    resources :products
    resources :coupons do
      resources :user_coupons, only: [:index, :show]
    end
    resources :orders, except: [:new, :create, :destroy]
    resources :users, except: [:new, :create, :destroy]
  end

  scope :company do
    devise_for :companies, controllers: {
      :sessions => "companies/sessions",
    }
  end

  namespace :company, path: '/company' do
    resources :product_stocks
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }
end
