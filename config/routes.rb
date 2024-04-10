Rails.application.routes.draw do
  resources :restrictions
  resources :invites, only: [:create, :destroy]
  resources :participants
  resources :events
  resources :users
  resources :drawings do
    collection do
      post 'persisted_drawing'
      post 'fast_draw', to: 'drawings#create_fast_draw'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: 'application#health_check'

  # TODO: Adjust needed routes + CRUD actions
end
