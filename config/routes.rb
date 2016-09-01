Rails.application.routes.draw do

  devise_for :users, path_names: {sign_in:"login", sign_out:"logout"},
                     :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  root 'static_pages#home'

  get 'users/:id',    to: 'users#show',    as: 'user'
  get 'users',        to: 'users#index',   as: 'users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
