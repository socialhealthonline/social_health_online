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

  # Contact
  get 'contact' => 'contact#new'
  post 'contact' => 'contact#create'

  # Authentication vanity routes
  get 'signin' => 'sessions#new', as: 'signin'
  delete 'signout' => 'sessions#destroy', as: 'signout'

  # Sessions
  resources :sessions, only: [:new, :create, :destroy]

  # Console
  get 'console' => 'console#index'
  namespace :console do
    root to: 'console#index', as: 'root'
  end

end
