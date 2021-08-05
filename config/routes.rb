Rails.application.routes.draw do

  root to: 'homes#top'
  devise_for :users

  get 'home/about' => 'homes#about', as: "about"

  resources :books, only:[:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only:[:create, :destroy]
    resources :book_comments, only:[:create, :destroy]
  end

  resources :users, only:[:create, :index, :show, :edit, :update] do
    resource :relationships, only:[:create, :destroy]

    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    #followingsとfollowersは一覧ページ用に定義したアクション
  end

end

