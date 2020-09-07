Rails.application.routes.draw do
  root                     "homes#index"
  get "/login",        to: "homes#index"
  get "sign_up",       to: "homes#index"
  get "/users",        to: "homes#index"
  get "/goals",        to: "homes#index"
  get "/work_records", to: "homes#index"
  get "/debug",        to: "homes#index"

  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only:          [:index, :create, :update, :destroy] do
        delete "/goals/multiple",        to: "goals#destroyMultiple"
        delete "/work_records/multiple", to: "work_records#destroyMultiple"

        resources :goals, only:        [:index, :create, :update, :destroy]
        resources :work_records, only: [:index, :create, :update, :destroy]
      end

      post     "/auth",    to: "authentications#create"
      post     "/login",   to: "sessions#create"
      delete   "/logout",  to: "sessions#destroy"
    end
  end
end
