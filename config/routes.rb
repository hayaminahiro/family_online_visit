Rails.application.routes.draw do
  resources :users do
    member do
      get :video_room
    end
    resources :reservations
  end



  resources :residents
  resources :informations
end
