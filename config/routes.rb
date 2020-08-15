Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resources :reservations
  end

  resources :residents
  resources :informations
end
