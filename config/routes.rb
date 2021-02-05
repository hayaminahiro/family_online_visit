Rails.application.routes.draw do
  root 'static_pages#top'

  # メール機能 ============================================================================
  get '/request_mail/preview', to: 'request_mails#preview_mail'
  post '/request_mail/create', to: 'request_mails#send_mail'

  # 新規ユーザ作成（施設・ご家族） ========================================================
  resources :signup do
    collection do
      get 'step1'
      get 'step2' # ここで、入力が終了
      get 'step3'
      get 'search'
    end
  end

  # devise（施設・ご家族） ================================================================
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
    resources :reservations do # 予約機能
      get :index_week, on: :collection
      get '/reservation_time/:date', on: :collection, to: 'reservations#reservation_time', as: :reservation_time
    end
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
    end
    resources :rooms, only: %i[new create edit update]
  end

  # カレンダー設定 =========================================================================
  resources :calendar_settings, except: :index

  # 利用施設登録 ==========================================================================
  resources :facility_users, only: %i[new update destroy] do
    member do
      patch :facility_update
    end
  end

  # 入居者 ================================================================================
  resources :residents do
    resources :memories do # 思い出アルバム
      delete '/delete_image/:memory_id/:column', on: :collection, to: 'memories#delete_image', as: :delete_image
    end
  end

  # 入居者申請 ============================================================================
  resources :request_residents

  # 入居者登録 ============================================================================
  resources :relatives, except: %i[new create] do
    patch :update_relatives, on: :collection
    post :confirm, on: :member
  end
  post '/relatives/new', to: 'relatives#new', as: :new_relative

  # お知らせ ==============================================================================
  resources :informations do
    get :top_notice, on: :collection
  end

  # タグ ==================================================================================
  resources :tags
  resources :tag_images

  # お問い合わせ===============================================================================
  resources :inquiries do
    collection do
      get :inquiry
      get :inquiry_system
      post :create_system
    end
  end
end
