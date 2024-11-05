Rails.application.routes.draw do

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :users,controllers: {
  sessions: 'public/sessions',
  registrations: 'public/registrations'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin,skip: [:registrations,:passwords], controllers: {
  sessions: 'admin/sessions'
  }

  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    get 'users/mypage' => 'users#mypage'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/unsubscribe'
    patch 'users/withdraw'
    resources :stores, only: [:index, :show] do
      resources :reviews, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    end

  end

  namespace :admin do

    resources :stores, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :users, only:[:index, :show, :edit, :update]
  end
end
