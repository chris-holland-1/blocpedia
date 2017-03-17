Rails.application.routes.draw do

  devise_for :user

  get 'charges/create'

  get "log_in" => 'sessions#new', :as => "log_in"
  get "log_out" => 'sessions#destroy', :as => "log_out"


  get "sign_up" => "users#new", :as => "sign_up"

  get "my_account" => "users#show", :as => "my_account"

  get 'users/confirm' => 'users#confirm'

  get 'about' => 'welcome#about'

  get 'index' => 'welcome#index'

  root :to => "sessions#new"

  resources :users
  resources :sessions
  resources :wikis
  resources :charges, only: [:new, :create]

  match "users/:id/downgrade" => "users#downgrade", :as => "downgrade_user", via: [:get, :post]
end
