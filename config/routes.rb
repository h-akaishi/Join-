Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show], :path => 'user/page'
  root to: "top#index"
end
