Rails.application.routes.draw do
  root 'static_pages#top'

  devise_for :facilities, controllers: {
      sessions:      'facilities/sessions',
      passwords:     'facilities/passwords',
      registrations: 'facilities/registrations'
  }
  devise_for :users, controllers: {
      sessions:      'users/sessions',
      passwords:     'users/passwords',
      registrations: 'users/registrations'
  }

  devise_scope :facility do
    get "facility_sign_in", :to => "facilities/sessions#new"
    get "facility_sign_out", :to => "facilities/sessions#destroy"
  end

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

  # resources :facilities do #facility_idが付与される
  #   resources :residents
  #   get :home #施設のホーム画面
  #   resources :users do
  #     member do #facility_id、user_idが付与される
  #       get :video_room
  #     end
  #     resources :reservations  #facility_id、user_id、reservations_idが付与される
  #   end
  #   resources :informations do
  #     collection do
  #       get 'show_notice' # トップお知らせ表示
  #     end
  #   end
  # end

end
