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


# 修正前
  # resources :users do
  #   member do  #user_idが付与される
  #     get :video_room
  #   end
  #   resources :facilities do #user_id、facility_idが付与される
  #     resources :residents
  #     #施設のホーム画面
  #     get :facility_home
  #   end
  #   resources :reservations  #user_id、reservations_idが付与される
  # end


  # resources :informations do
  #   collection do  #idが付与されない
  #     # お知らせ表示
  #     get 'show_notice'
  #   end
  # end


  # 修正後
  resources :facilities do #facility_idが付与される
    resources :residents
    get :home #施設のホーム画面
    resources :users do
      member do #facility_id、user_idが付与される
        get :video_room
      end
      resources :reservations  #facility_id、user_id、reservations_idが付与される
    end
    resources :informations do
      collection do
        get 'show_notice' # トップお知らせ表示
      end
    end
  end

end
