Rails.application.routes.draw do

  devise_for :users
  root 'recipes#index'

  resources :recipes do
    resources :recipe_comments, only: [:create]

    resources :blogs, only: [:new, :create, :show, :destroy, :edit] do
      resources :blog_comments, only: [:create]
    end

    resources :likes, only: [:create, :destroy]

    member do
      get 'mypage'
    end
    
    collection do
      get 'about'
      get 'instruction'
    end
  end 

  resources :searches, only: [:index] do 
    collection do
      get 'result'
    end
  end

  resources :favorite_recipes, only: [:new, :create, :show]

  resources :lists, only: [:create, :destroy]


end
