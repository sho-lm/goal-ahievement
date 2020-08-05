Rails.application.routes.draw do
  root      "homes#index"
  # get       "/login",     to: "sessions#new"
  # post      "/login",     to: "sessions#create"
  # delete    "/logout",    to: "sessions#destroy"
  # resources :users do
  #   resources :goals
  #   resources :work_records
  # end

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only:          [:index, :show, :create, :update, :destroy] do
        resources :goals, only:        [:index, :create, :update, :destroy]
        resources :work_records, only: [:index, :create, :update, :destroy]
      end

      post     "/auth",    to: "authentications#create"
      post     "/login",   to: "sessions#create"
      delete   "/logout",  to: "sessions#destroy"
    end
  end
end
