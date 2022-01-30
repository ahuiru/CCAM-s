Rails.application.routes.draw do
  root "home#index"
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :photos
  resources :users
  resources :relationships, only: [:create, :destroy]
end
