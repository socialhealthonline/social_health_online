Rails.application.routes.draw do
  root 'public#index'

  # About
  get 'about-us' => 'public#about'

  # Join
  get 'join' => 'public#join'

  # Service
  get 'service' => 'public#service'

  # Partners
  get 'partners' => 'public#partners'

  # News
  get 'news' => 'public#news'

  # Terms
  get 'terms' => 'public#terms'

  # Privacy
  get 'privacy' => 'public#privacy'

  # Contact
  get 'contact' => 'contact#new'
  post 'contact' => 'contact#create'

  # Authentication vanity routes
  get 'signin' => 'sessions#new', as: 'signin'
  delete 'signout' => 'sessions#destroy', as: 'signout'

  # Authentication
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # Console
  get 'console' => 'console#index'
  namespace :console do
    root to: 'console#index', as: 'root'
    resources :customers do
      resources :users
    end
  end

end
