Rails.application.routes.draw do
  namespace :api do
    get 'class_feedbacks/index'
    get 'courses_rating/index'
  end
  get 'class_feedbacks/new'
  post 'class_feedbacks/create'
  get 'home/index'
  get 'thank_you', to: 'thank#thank_you'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # scope 'api' do
  #   get 'class_feedbacks', to: 'class_feedback#index'
  #   get 'courses_rating', to: 'courses_rating#index'
  # end
end
