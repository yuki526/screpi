class ListsController < ApplicationController
  before_action :authenticate

  def create
    
  end



  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end
end
