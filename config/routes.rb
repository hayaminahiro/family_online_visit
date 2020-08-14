Rails.application.routes.draw do

  root 'static_pages#top'

  resources :users do
    resources :reservations
  end

  resources :residents
  resources :informations

end
