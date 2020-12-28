class LikesController < ApplicationController

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_to recipe_path(params[:id])
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_to recipe_path(params[:id])
  end

end
