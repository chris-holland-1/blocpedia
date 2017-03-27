Rails.application.routes.draw do
  get 'about' => 'welcome#about'
  get 'index' => 'welcome#index'

  devise_for :users, controllers: { sessions: 'users/sessions' }

  resources :users
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :downgrade, only: [:new, :create]

  post 'downgrade/create'

  root 'welcome#index'
end
