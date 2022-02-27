Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :photos do
    resource :like
    resources :comments, :except => :show
  end
  resources :users do
    resources :likes
    get :search, on: :collection
    resources :followers
    resources :followings
  end
  resources :relationships, only: [:create, :destroy]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
end
