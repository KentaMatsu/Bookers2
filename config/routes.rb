Rails.application.routes.draw do
  
  root to: 'homes#top'
  devise_for :users
  
  get 'home/about' => 'homes#about', as: "about"
  
  resources :books, only:[:create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, onry:[:create, :destroy]
  end
  
  resources :users, only:[:create, :index, :show, :edit, :update]
  

  
end

