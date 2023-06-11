Rails.application.routes.draw do
  root to: "owners#index"

  resources :owners do
    resources :machines, only: [:index]
  end

  resources :machines, only: [:show]

  post "/machines/:id/snacks", to: "machine_snacks#create"

  resources :snacks, only: [:show]
end
