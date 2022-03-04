Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :photos do
    resource :like
    resources :comments, :except => :show
  end
  resources :users do
    resources :likes
    resources :followers
    resources :followings
  end
  get 'search' => 'searches#search'
  resources :relationships, only: [:create, :destroy]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  get '/ranks' => 'ranks#index'
end
