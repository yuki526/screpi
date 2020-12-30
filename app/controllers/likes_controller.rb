class LikesController < ApplicationController
  before_action :authenticate

  def create
    @like = current_user.likes.create(recipe_id: params[:recipe_id])
    redirect_to recipe_path(params[:recipe_id])
  end

  def destroy
    @like = Like.find_by(recipe_id: params[:recipe_id], user_id: current_user.id)
    @like.destroy
    redirect_to recipe_path(params[:recipe_id])
  end


  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

end
