Rails.application.routes.draw do
  # Locale
  put "locale/:locale", to: "locale#update", as: "update_locale"

  # Front-page english
  scope "/:locale", locale: /en/, as: :en do
    get "/", to: "home#index", as: :home
  end

  # Front-page french
  scope "/:locale", locale: /fr/, as: :fr do
    get "/", to: "home#index", as: :home
  end

  # Root
  root to: "home#redirect_or_index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :user
    end
  end

  resources :user do
    patch "deny_profile", to: "user#update_denied_profiles"
    patch "clear_list", to: "user#clear_denied_profiles"
  end

  # Search
  get 'search', to: 'search#index'

  post 'evaluate_location', to: 'location#evaluate_location'

  resources :messages do
    member do
      post :new
    end
  end
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
    collection do
      get :trashbin
      post :empty_trash
    end
  end

  # Sidekiq panel
  require "sidekiq/web"
  mount Sidekiq::Web => "sidekiq"

  # Devise & user related
  # https://github.com/plataformatec/devise/blob/master/lib/devise/rails/routes.rb
  devise_for :users, skip: [:registrations, :password, :confirmation]
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: "account",
      controller: "registrations",
      as: :user_registration do
        get :cancel
      end

    resource :password,
      only: [:new, :create, :edit, :update],
      path: "password",
      controller: "devise/passwords",
      path_names: {
        new: "forgot",
        edit: "reset",
      },
      as: :user_password

      resource :confirmation,
        only: [:show, :new, :create],
        path: "account/confirmation",
        controller: "devise/confirmations",
        as: :user_confirmation

      resource :password,
        only: [:edit, :update],
        path: "account/password",
        controller: "account/passwords",
        as: :account_password

    # # Authentification
    # get     "sign-in"   => "devise/sessions#new",     as: :new_user_session
    # post    "sign-in"   => "devise/sessions#create",  as: :user_session
    # delete  "sign-out"  => "devise/sessions#destroy", as: :destroy_user_session
  end
end
