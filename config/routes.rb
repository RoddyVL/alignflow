Rails.application.routes.draw do
  devise_for :users
  root to: "projects#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :projects, only: %i[index show create] do
    resources :skills, only: %i[new create]
    resources :niches, only: %i[new create index show] do

      member do
        patch :select
      end

      resources :ideas do
        member do
          patch :select_idea
        end

        resources :category, only: [:index] do
          member do
            patch :select_category
          end
        end

      end
      post :generate_ai_data, on: :collection
      resources :avatars, only: [:show]
      resources :offers, only: [:show]
      resources :hypothesis_results, only: [:show]
      resources :messages, only: [:show]
      resources :scripts, only: [:show]
      resources :ai_responses, only: [:show]
    end
  end
end
