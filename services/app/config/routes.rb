# frozen_string_literal: true

Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq', constraints: AdminConstraint.new

  namespace :api do
    resources :lessons, only: [] do
      member do
        post :check
      end
    end
  end

  scope module: :web do
    root 'home#index'
    get 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth

    get '/403', to: 'errors#forbidden', as: :not_forbidden_errors
    get '/404', to: 'errors#not_found', as: :not_found_errors
    match '/500', to: 'errors#server_error', via: :all

    resources :pages, only: [:show]
    resource :session, only: %i[new create destroy]
    resource :locale, only: [] do
      member do
        get :switch
      end
    end
    resources :users, only: %i[new create]
    resource :remind_password, only: %i[new create]
    resource :password, only: %i[edit update]

    resources :languages, only: [:show] do
      scope module: :languages do
        resources :lessons, only: [:show] do
          get :next_lesson, on: :member
          get :prev_lesson, on: :member
        end
      end
    end

    namespace :admin do
      root 'home#index'

      resources :languages, only: %i[index new edit update create] do
        scope module: :languages do
          resources :versions, only: %i[index create]
        end
      end
    end

    namespace :account do
      resource :profile, only: %i[edit update destroy]
    end
  end
end
