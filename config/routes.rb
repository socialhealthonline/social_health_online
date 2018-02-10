Rails.application.routes.draw do
  root 'public#index'

  # Authentication vanity routes
  get 'login' => 'sessions#new', as: 'login'
  delete 'logout' => 'sessions#destroy', as: 'logout'

  # Sessions
  resources :sessions, only: [:new, :create, :destroy]

  # Console
  get 'console' => 'console#index'
  namespace :console do
    root to: 'console#index', as: 'root'
  end

end
