Rails.application.routes.draw do
  resources :products, only: [:index, :show]

  #scope '/admin' do
  #  devise_for :admins
  #end
  scope :admin do
    devise_for :admins
  end

  namespace :admin, path: '/admin' do
    resources :products
  end

  devise_for :users
end
