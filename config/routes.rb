Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :books, only: :show

  scope path: 'categories' do
    get '/',    to: 'categories#show', as: :categories
    get '/:id', to: 'categories#show', as: :category
  end

  scope :cart do
    get  '/', to: 'cart#edit', as: :cart
    post '/book/:id', to: 'cart#add_book', as: :cart_add_book
  end

  # resource :cart, only: [:show]
  resources :orders, only: [:index, :edit]

  resources :order_item, only: [:create, :update, :destroy]
  resource :checkout, only: [:show, :update]

  # resource :cart_item, controller: :order_item, only: [:create, :update, :destroy]
  # post   '/:class/:id', to: 'cart#add_product',    as: :cart_add_product
  # delete '/:class/:id', to: 'cart#remove_product', as: :cart_remove_product

end
