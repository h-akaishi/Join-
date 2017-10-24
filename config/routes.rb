Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_scope :user do
  #   delete :sign_out, to: 'devise/session#destroy', as: :destroy_user_session
  # end
  resources :users, param: :user_name, only: %i(show edit update), :path => '/' do
    get 'new_edit', :on => :member
  end
  root to: "top#index"
end
