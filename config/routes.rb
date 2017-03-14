Rails.application.routes.draw do

  resources :wikis

  devise_for :users

  devise_scope :user do
    get "/some/route" => "some_devise_controller"
  end

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
