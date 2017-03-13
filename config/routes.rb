Rails.application.routes.draw do
  devise_for :models
  devise_for :users

  devise_scope :user do
  get 'login', to: 'devise/sessions#new'
end

devise_scope :user do
  delete 'logout', to: 'devise/sessions#destroy'
end

  get "welcome/index"

  get "welcome/about"

  root 'welcome#index'
end
