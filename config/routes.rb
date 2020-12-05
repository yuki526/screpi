Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'

  resources :recipes do
    resources :recipe_commemts, only: [:create]

    resources :blogs, only: [:new, :create] do
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

end
