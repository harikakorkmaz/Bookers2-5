Rails.application.routes.draw do
  
  devise_for :users
  root 'homes#top'
  get 'home/about' => 'homes#about', as: 'about'
  get 'search' => 'search#search', as: 'search'
  
  resources :users, only: [:show,:index,:edit,:update]
  resources :relationships, only: [:create, :destroy]


  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end 
  
  resources :users do
    member do
      get :following, :followers
    end
  end
  
end