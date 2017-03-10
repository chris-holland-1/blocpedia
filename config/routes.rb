Rails.application.routes.draw do
  # devise_for :admins

  get "welcome/index"

  get "welcome/about"

  root 'welcome#index'
end
