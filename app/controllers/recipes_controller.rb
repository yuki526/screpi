class RecipesController < ApplicationController
  before_action :authenticate, only: [:mypage]

  
  def index
  end
  
  def about
  end
  
  def mypage
  end

  def create
    
  end

  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

end
