Rails.application.routes.draw do
  resource :csv_upload, only: [:new, :create]
  # get "up" => "rails/health#show", as: :rails_health_check

  get "graph", to: "graph#show"

  root "graph#show"
end
