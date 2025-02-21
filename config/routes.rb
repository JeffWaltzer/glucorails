Rails.application.routes.draw do
  get "graph/show"
  resources :glucose_csvs
  # get "up" => "rails/health#show", as: :rails_health_check
  root "glucose_csvs#index"
end
