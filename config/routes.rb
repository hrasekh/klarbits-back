Rails.application.routes.draw do  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users,
  path: '',
  path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    # registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    # registrations: 'users/registrations'
  }

  namespace :api do
    namespace :v1 do
      resources :home, only: [:index]
      resources :questions, param: :uuid

      resources :categories, param: :slug do
        resources :subcategories, param: :slug 
      end
    end
  end

end
