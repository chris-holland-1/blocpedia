Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    get "/some/route" => "some_devise_controller"
  end

  get "welcome/index"

  get "welcome/about"

  root 'welcome#index'
end
