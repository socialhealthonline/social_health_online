Rails.application.routes.draw do
  root 'public#index'

  # Public pages
  get 'about-us' => 'public#about'
  get 'join'     => 'public#join'
  get 'service'  => 'public#service'
  get 'partners' => 'public#partners'
  get 'news'     => 'public#news'
  get 'terms'    => 'public#terms'
  get 'privacy'  => 'public#privacy'

  # Contact
  get 'contact'  => 'contact#new'
  post 'contact' => 'contact#create'

  # Authentication vanity routes
  get 'signin'     => 'sessions#new', as: 'signin'
  delete 'signout' => 'sessions#destroy', as: 'signout'

  # Authentication
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # My profile
  get 'my-profile' => 'profile#edit', as: 'profile'
  patch 'profile' => 'profile#update', as: 'update_profile'

  # Manage
  namespace :manage do
    get 'customer' => 'customer#edit', as: 'edit_customer'
    patch 'customer' => 'customer#update', as: 'update_customer'
  end

  # Console
  get 'console' => 'console#index'
  namespace :console do
    root to: 'console#index', as: 'root'
    resources :partners
    resources :customers do
      resources :users
    end
  end

end
