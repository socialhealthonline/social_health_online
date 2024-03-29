Rails.application.routes.draw do
  root "public#index"

  get "cities/:state", to: "application#cities"

  # Public Pages
  get "about-us" => "public#about"
  get "careers" => "public#careers"
  get "join" => "public#join"
  get "service" => "public#service"
  get "service_highlights" => "public#service_highlights"
  get "service_screenshots" => "public#service_screenshots"
  get "participation" => "public#participation"
  get "affiliate_locator" => "public#affiliate_locator"
  get "affiliates" => "public#affiliates"
  get "member_locator" => "public#member_locator"
  get "members" => "public#members"
  get "pricing" => "public#pricing"
  get "news" => "public#news"
  get "affiliate_agreement" => "public#affiliate_agreement"
  get "saas_agreement" => "public#saas_agreement"
  get "terms" => "public#terms"
  get "privacy" => "public#privacy"
  get "faq" => "public#faq"

  # Create Member
  resources :members_registration, only: [:new, :create]

  # User Registration
  get "users_registration" => "users_registration#new"
  post "users_registration" => "users_registration#create"

  # Affiliate Registration
  get "affiliates_registration" => "affiliates_registration#new"
  post "affiliates_registration" => "affiliates_registration#create"

  #Stripe Webhooks
  mount StripeEvent::Engine, at: '/stripe_events'

  # Contact
  get "contact" => "contact#new"
  post "contact" => "contact#create"

  # Authentication vanity routes
  get "signin" => "sessions#new", as: "signin"
  delete "signout" => "sessions#destroy", as: "signout"

  # Authentication
  resources :sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  # My Profile
  get "my-profile" => "profile#edit", as: "profile"
  patch "profile" => "profile#update", as: "update_profile"
  get 'request_deactivation' => 'profile#new'
  post 'request_deactivation' => 'profile#create'

  # My Settings
  resource :my_settings, only: [:show, :update]

  # Matchmaker
  get 'matchmaker' => 'matchmakers#index'
  get 'fetch_user' => 'matchmakers#fetch_user'

  # Bulletin Board
  get 'bulletins' => 'bulletins#bulletins'

  # Verify ACH account
  resource :ach, controller: 'ach', only: [:edit, :update]

  # Communities
  resources :members, path: :communities, as: :community, controller: :communities do
    resources :events, only: [:index, :show] do
      post 'create_or_switch_rsvp', on: :member
    end
  end

  get 'explore_communities' => 'communities#explore_communities'
  get 'event_search' => 'communities#event_search'
  get 'leaderboard' => 'communities#leaderboard'
  get 'user_finder' => 'communities#user_finder'
  get 'event_suggestions' => 'communities#new'
  post 'event_suggestions' => 'communities#create'
  get 'announcement_suggestions' => 'communities#new_suggest'
  post 'announcement_suggestions' => 'communities#create_suggest'
  get 'challenge_new' => 'communities#challenge_new'
  get 'challenge_index' => 'communities#challenge_index'
  post 'challenge_new' => 'communities#challenge_create'
  get 'connection_index' => 'communities#connection_index'

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
    resources :challenges
    resources :connections
    resources :users do
      collection do
        get 'export_user_csv'
      end
    end
  end

  # Social Tracker
  namespace :social_tracker do
    get "log" => "events#new"
    post "log" => "events#create"
    get "history" => "events#index"
    get "history/:id" => "events#show"
  end

  # Social Fitness
  namespace :social_fitness do
    get "log" => "fitness#new"
    post "log" => "fitness#create"
    get "history" => "fitness#index"
    get "history/:id" => "fitness#show"
    get "plan" => "fitness#plan"
    get "console/fitness_plans/:id" => "fitness#plan_details", as: :plan_details
  end

  # Rewards
  get "rewards" => "rewards#index"

  # Dashboard
  get "home" => "home#index"

  # Console
  get "lookups" => 'console#lookups'
  get "console" => "console#index"
  namespace :console do
    root to: "console#index", as: "root"
    resources :affiliates do
      collection do
        get 'export_csv'
      end
    end
    resources :news
    resources :rewards
    resources :manage_bulletins
    resources :event_links
    resources :fitness_plans
    resources :notifications
    resources :members do
      collection do
        get 'export_global_user_csv'
        get 'export_user_csv'
        get 'export_member_csv'
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
      delete "members/:name/users/:user_id/history/:id" => "history#destroy", as: :delete_social_fitness_log
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

  # Help
  get "help" => "help#index"
  get 'service_support' => 'help#new'
  post 'service_support' => 'help#create'

  # My Bulletins
  resources :my_bulletins

  # Invite Guests
  get "invite_guests" => "invite_guests#new"
  post "invite_guests" => "invite_guests#create"

  # Invitation Reminder
  get "invitation_reminder" => "invitation_reminder#new"
  post "invitation_reminder" => "invitation_reminder#create"

  # Event Reminder
  get "event_reminder" => "event_reminder#new"
  post "event_reminder" => "event_reminder#create"

  # Share Link
  get "share_link" => "share_link#new"
  post "share_link" => "share_link#create"

  # Affiliates
  get "affiliates_search" => "affiliates#index"

  # Discounts
  get "discounts_finder" => "discounts_finder#index"

  # Event Links
  get "event_links" => "event_links#index"

  # Report Issues
  get "issues" => "issues#new"
  post "issues" => "issues#create"

  # My Achievements
  get "my_achievements" => "my_achievements#index"

  # My Events
  get "my_events" => "my_events#index"

  # Sitemap
  get "sitemap" => "sitemap#index"

  # My Contacts
  resources :my_contacts

end
