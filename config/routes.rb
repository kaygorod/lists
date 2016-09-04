Rails.application.routes.draw do

  devise_for :users, path_names: {sign_in:"login", sign_out:"logout"},
                     :controllers => { :omniauth_callbacks => "users/omniauth_callbacks"}
  root 'static_pages#home'

  get 'users/:id',    to: 'users#show',    as: 'user'
  get 'users',        to: 'users#index',   as: 'users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :lists do
    member do
      get 'sort_time_desc'
      get 'sort_time_asc'
      get 'sort_comts_desc'
      get 'sort_comts_asc'
      get 'sort_rating_desc'
      get 'sort_rating_asc'
      get 'plugin'
      get 'new_item'
    end
    member do
        get 'iframe'
      end
    resources :items do
      member do
        get 'item_comments'
      end
      resources :votes do
        post 'like', on: :member
      end
    end
    resources :comments
  end
  resources :plugin, :only => [:index, :show] do
  collection do
    get 'list_comments'
    get 'item_comments'
    end
  end

end
