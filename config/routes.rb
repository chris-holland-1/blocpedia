Rails.application.routes.draw do

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  resources :wikis

  devise_for :users

  devise_scope :user do
    get "/some/route" => "some_devise_controller"
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
