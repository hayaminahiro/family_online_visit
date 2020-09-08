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
      registrations: 'users/registrations',
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :facility do
    get "facility_sign_in", :to => "facilities/sessions#new"
    get "facility_sign_out", :to => "facilities/sessions#destroy"
  end

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  # ご家族目線のルーティング
  resources :users do # /users/:id/~~~
    resources :reservations # /users/:user_id/~~~
    resources :facilities do # user_id, facility_id付与
      get :home #施設のホーム画面
      resources :residents # /users/:user_id/facilities/:facility_id/~~~(施設を介した入居者)
        member do # /users/:user_id/facilities/:id/~~~
          get :video_room # /users/:user_id/facilities/:id/video_room
          patch :change_admin
          get 'video_room'
          patch 'room_word_update'
        end
    end
  end

  # 施設目線のルーティング
  resources :facilities do # /facilities/:id/~~~
    resources :residents do # /facilities/:facility_id/residents/:id/~~~
      collection { post :import } # CSVインポート機能
    end
    resources :users do
      member do
        get :video_room # /facilities/:facility_id/users/:id/video_room
      end
    end
    resources :informations do # /facilities/:facility_id/informations/~~~
      collection do
        get 'top_notice' # お知らせ表示
      end
    end

  end

  # resources :users do
  #   member do
  #     get :video_room
  #     patch :change_admin
  #     get 'video_room'
  #     patch 'room_word_update'
  #   end
  #   resources :reservations
  # end

  # resources :residents do
  #   collection { post :import }
  # end
  # resources :informations do
  #   collection do
  #     # お知らせ表示
  #     get 'top_notice'
  #   end
  # end

  # resources :facilities

end
