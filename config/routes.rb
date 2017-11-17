Rails.application.routes.draw do
  root 'diaries#index'

  resources :diaries, except: [:index] do
    resources :comments, only: [:create, :destroy], controller: 'diary_comments'
    resources :evaluations, only: [:create, :destroy], controller: 'diary_evaluations'
  end

  resources :carts, only: [:create, :update, :edit], controller: 'orders' do
    member do
      patch :confirm
      delete :line_items, to: 'orders#destroy_cart_line_item'
    end
  end
  get 'carts', to: 'orders#cart'

  resources :orders, only: [:index, :show] do
    member do
      patch :cancel
      patch :reorder
    end
  end

  resources :products, only: [:index, :show]
  resources :coupons, only: [:index, :show]
  resources :user_points, only: [:index, :create]

  get 'mypage', to: 'users#show'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }

  scope :backoffice do
    devise_for :admins, controllers: {
      sessions: "admins/sessions",
    }
  end

  namespace :backoffice, path: '/backoffice' do
    resources :products
    resources :coupons
    resources :companies
    resources :orders, except: [:new, :create, :destroy]
    resources :users, except: [:new, :create] do
      resources :points, only: [:new, :create], controller: 'user_points'
    end
  end

  devise_for :companies, controllers: {
    sessions: "companies/sessions",
    registrations: "companies/registrations",
  }

  devise_scope :company do
    get 'companies/edit', to: 'companies/registrations#edit', as: 'edit_company_registration'
    patch 'companies', to: 'companies/registrations#update', as: 'company_registration'
  end

  namespace :companies, path: '/companies' do
    resources :orders, only: [:index, :show] do
      member do
        patch 'prosessing'
        patch 'shipped'
        patch 'cancel'
        patch 'reorder'
      end
    end

    resources :products, only: [:index, :show] do
      resources :stocks, only: [:create, :destroy], controller: 'products'
    end
    get 'stocks', to: 'products#stocks'
  end
end
