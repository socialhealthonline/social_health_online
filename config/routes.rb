Rails.application.routes.draw do
  root "public#index"

  # Public pages
  get "about-us" => "public#about"
  get "join" => "public#join"
  get "service" => "public#service"
  get "membership" => "public#membership"
  get "affiliate_locator" => "public#affiliate_locator"
  get "affiliates" => "public#affiliates"
  get "member_locator" => "public#member_locator"
  get "members" => "public#members"
  get "pricing" => "public#pricing"
  get "news" => "public#news"
  get "terms" => "public#terms"
  get "privacy" => "public#privacy"

  # Contact
  get "contact" => "contact#new"
  post "contact" => "contact#create"

  # Authentication vanity routes
  get "signin" => "sessions#new", as: "signin"
  delete "signout" => "sessions#destroy", as: "signout"

  # Authentication
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # My profile
  get "my-profile" => "profile#edit", as: "profile"
  patch "profile" => "profile#update", as: "update_profile"

  # Communities
  resources :members, path: :communities, as: :community, controller: :communities do
    resources :events, only: [:index, :show]
  end

  # Manage
  namespace :manage do
    get "member" => "member#edit", as: "edit_member"
    patch "member" => "member#update", as: "update_member"
    resources :events
  end

  # Dashboard
  get 'dashboard' => 'dashboard#index'

  # Console
  get "console" => "console#index"
  namespace :console do
    root to: "console#index", as: "root"
    resources :affiliates
    resources :news
    resources :notifications
    resources :members do
      resources :users
    end
    resources :users, path: :admins, as: :admins, controller: :admins
  end

  # Mailbox
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
end
