Rails.application.routes.draw do
  devise_for :users
  resources :users, param: :user_name, only: [:show], :path => '/'
  root to: "top#index"
end
