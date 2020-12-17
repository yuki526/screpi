Rails.application.routes.draw do

  devise_for :users
  root 'recipes#index'

  resources :recipes do
    resources :recipe_comments, only: [:create]

    resources :blogs, only: [:new, :create, :destroy] do
      resources :blog_comments, only: [:create]
    end

    member do
      get 'mypage'
    end
    
    collection do
      get 'about'
      get 'instruction'
    end
  end 

  resources :favorite_recipes, only: [:new, :create]

  resources :lists, only: [:create, :destroy]

end
