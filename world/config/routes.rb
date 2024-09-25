Rails.application.routes.draw do
  root "home#index"

  get "classes/index", as: :classes_index

  get "users/me" => "me#index", as: :me_index
  get "users/me/mentor/availability" => "me#show_mentor_availability", as: :me_mentor_availability
  post "users/me/mentor/opt" => "me#opt_mentor", as: :me_mentor_opt
  post "users/me/bio" => "me#update_bio", as: :me_bio_update
  post "users/me/mentor/availability/calendar" => "me#show_calendar", as: :me_mentor_calendar

  get "users/:user_id/profile_picture/large" => "users#large_profile_picture", as: :large_profile_picture
  get "users/:user_id/profile_picture" => "users#profile_picture", as: :profile_picture
  post "users/:user_id/skills/:skill_id/endorse" => "users#endorse_skill"

  resources :mentors, only: [ :index, :show ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
