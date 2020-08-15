Rails.application.routes.draw do

  root 'static_pages#top'

  resources :users do
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
