Rails.application.routes.draw do
  resources :users do
    resources :reservations
  end

  resources :residents
  resources :informations
end
