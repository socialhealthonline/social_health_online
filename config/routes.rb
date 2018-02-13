Rails.application.routes.draw do
  root 'public#index'

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
