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
      resources :users, only: [:show]
    end
  end
end
