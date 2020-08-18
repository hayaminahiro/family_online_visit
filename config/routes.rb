Rails.application.routes.draw do
  root 'static_pages#top'

  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  resources :users do
    member do
      get :video_room
    end
    resources :reservations
  end



  resources :residents
  resources :informations do
    collection do
      # お知らせ表示
      get 'show_notice'
    end
  end

end
