Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'

  resources :recipes do
    member do
      get 'mypage'
    end
    collection do
      get 'about'
    end
  end 
end
