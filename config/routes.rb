Rails.application.routes.draw do
  root 'static_pages#top'

  resources :signup do
    collection do
      get 'step1'
      get 'step2' # ここで、入力が終了
      get 'step3'
    end
  end

  # devise（施設・ご家族） ==================================================================================
  devise_for :facilities, controllers: {
      sessions: 'facilities/sessions',
      passwords: 'facilities/passwords',
      registrations: 'facilities/registrations'
  }

  devise_for :users, controllers: {
      sessions: 'users/sessions',
      passwords: 'users/passwords',
      registrations: 'users/registrations',
      omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :facility do
    get 'facility_sign_in', to: "facilities/sessions#new"
    get 'facility_sign_out', to: "facilities/sessions#destroy"
  end

  devise_scope :user do
    get 'sign_in', to: "users/sessions#new"
    get 'sign_out', to: "users/sessions#destroy"
    get 'privacy', to: "users/sessions#privacy"
  end

  # 施設 ==================================================================================
  resources :facilities do
    get :home # ユーザログイン後の各施設のホーム画面
    get :facility_home, on: :member # 施設ログイン後のホーム画面
    # get 'inquiry', to: "facilities/inquiries#inquiry"
    # post 'create', to: "facilities/inquiries#create"
    resources :inquiries do
      get :inquiry, on: :collection
    end
  end

  # ご家族 ================================================================================
  resources :users do
    member do
      get :video_room
      patch :room_word_update # Room_Name登録のため追加
    end
  end

  # 利用施設登録 ==========================================================================
  resources :facility_users, only: %i[new update]

  # 入居者 ================================================================================
  resources :residents do
    resources :memories # 思い出アルバム
  end

  # 入居者申請 ============================================================================
  resources :request_residents, only: %i[new create index]

  # 入居者登録 ============================================================================
  resources :relatives, except: %i[create edit] do
    patch :update_relatives, on: :collection
    patch :confirm, on: :member
  end

  # お知らせ ==============================================================================
  resources :informations do
    get :top_notice, on: :collection
  end

  # 予約 ==================================================================================
  resources :reservations

  # お問い合わせ===============================================================================
  resources :inquiries do
    collection do
      get :inquiry
      get :inquiry_system
      post :create_system
    end
  end
end
