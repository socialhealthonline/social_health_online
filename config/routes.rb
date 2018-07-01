Rails.application.routes.draw do
  root "public#index"

  get "cities/:state", to: "application#cities"

  # Public pages
  get "about-us" => "public#about"
  get "join" => "public#join"
  get "service" => "public#service"
  get "service_highlights" => "public#service_highlights"
  get "service_screenshots" => "public#service_screenshots"
  get "membership" => "public#membership"
  get "affiliate_locator" => "public#affiliate_locator"
  get "affiliates" => "public#affiliates"
  get "member_locator" => "public#member_locator"
  get "members" => "public#members"
  get "pricing" => "public#pricing"
  get "support" => "public#support"
  get "news" => "public#news"
  get "terms" => "public#terms"
  get "privacy" => "public#privacy"
  get "faq" => "public#faq"

  # Create Member
  resources :members_registration, only: [:new, :create]

  #Stripe webhooks
  mount StripeEvent::Engine, at: '/stripe_events'

  # Contact
  get "contact" => "contact#new"
  post "contact" => "contact#create"

  # Matchmaker
  get 'matchmaker' => 'matchmakers#index'
  get 'fetch_user' => 'matchmakers#fetch_user'

  # Authentication vanity routes
  get "signin" => "sessions#new", as: "signin"
  delete "signout" => "sessions#destroy", as: "signout"

  # Authentication
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # My profile
  get "my-profile" => "profile#edit", as: "profile"
  patch "profile" => "profile#update", as: "update_profile"

  # My settings
  resource :my_settings, only: [:show, :update]

  # Communities
  resources :members, path: :communities, as: :community, controller: :communities do
    resources :events, only: [:index, :show] do
      post 'create_or_switch_rsvp', on: :member
    end
  end

  get 'explore_communities' => 'communities#explore_communities'
  get 'event_search' => 'communities#event_search'

  # Manage
  namespace :manage do
    get "member" => "member#edit", as: "edit_member"
    patch "member" => "member#update", as: "update_member"
    namespace :social_tracker do
      get "/:name/users" => "history#users", as: :users
      get "/:name/users/:id/history" => "history#user_history", as: :member_user
      get "/:name/users/:id/history/:id" => "history#show", as: :user_history
    end
    resources :events
    resources :announcements
    resources :users
  end

  namespace :social_tracker do
    get "log" => "events#new"
    post "log" => "events#create"
    get "history" => "events#index"
    get "history/:id" => "events#show"
  end

  namespace :social_fitness do
    get "log" => "fitness#new"
    post "log" => "fitness#create"
    get "history" => "fitness#index"
    get "history/:id" => "fitness#show"
    get "resources" => "fitness#resources"
    get "plan" => "fitness#plan"
  end

  # Dashboard
  get "home" => "home#index"

  # Console
  get "console" => "console#index"
  namespace :console do
    root to: "console#index", as: "root"
    resources :affiliates do
      collection do
        get 'export_csv'
      end
    end
    resources :news
    resources :notifications
    resources :members do
      collection do
        get 'export_csv'
      end
      resources :users 
    end
    resources :users, path: :admins, as: :admins, controller: :admins
    namespace :social_tracker do
      get "members" => "history#members"
      get "members/:name/member_csv" => "history#member_csv", as: :member_csv
      get "members/:name/users" => "history#users", as: :member
      get "members/:name/users/:id/" => "history#user_history", as: :member_user
      get "members/:name/users/:user_id/history/:id" => "history#show", as: :member_user_social_event_log
      delete "members/:name/users/:user_id/history/:id" => "history#destroy", as: :delete_social_event_log
    end

    namespace :social_fitness do
      get "members" => "history#members"
      get "members/:name/member_csv" => "history#member_csv", as: :member_csv
      get "members/:name/users" => "history#users", as: :member
      get "members/:name/users/:id/" => "history#user_history", as: :member_user
      get "members/:name/users/:user_id/history/:id" => "history#show", as: :member_user_social_fitness_log
    end
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
    post :mark_as_deleted, on: :collection
  end

  # Media Center
  get "media_center" => "media_center#index"

  # Affiliates
  get "affiliates_search" => "affiliates#index"

  # Issues
  get "issues" => "issues#new"
  post "issues" => "issues#create"

  # My Favorites
  get "my_favorites" => "my_favorites#index"

  # My Contacts
  get "my_contacts" => "my_contacts#index"

end
