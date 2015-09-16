Rails.application.routes.draw do
  require 'sidekiq/web'
  # authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  # endf

  HighVoltage.configure do |config|
    config.home_page = 'home'
  end

  resources :podcasts do
    resources :episodes
    collection do
      get :search
    end
  end
  resources :users

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'
end
