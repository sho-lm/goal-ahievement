Rails.application.routes.draw do
  root      "goals#index"
  resources :users
  resources :goals
end
