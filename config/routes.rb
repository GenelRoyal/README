Rails.application.routes.draw do
  
  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  get 'search', to: 'search#result'
  get "search_tag" => "reviews#search_tag"

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

  # ゲストユーザー用
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    get 'users/mypage' => 'users#mypage'
    get 'users/information/edit' => 'users#edit'
    patch 'users/information' => 'users#update'
    get 'users/unsubscribe'
    patch 'users/withdraw'
    resources :users, only: [:show] do
      resources :reviews, only: [:index], controller: 'public/reviews'
      member do
        get :liked_reviews
      end
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :stores, only: [:index, :show] do
      resources :reviews, only: [:create, :index, :show, :edit, :update, :destroy] do
        resources :comments, only: [:create]
        resource :likes, only: [:create, :destroy]
      end
    end
  end

  namespace :admin do
    resources :stores, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :users, only:[:index, :show, :edit, :update, :destroy]
    resources :reviews, only:[:index, :show, :destroy]
  end
end
