Rails.application.routes.draw do
  devise_for :users
  root 'recipes#index'

  get 'recipes/about'
end
