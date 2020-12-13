class RecipeCommentsController < ApplicationController
before_action :authenticate

  def create
    @comment = RecipeComment.new(comment_params)
    @recipe = @comment.recipe
    @ingredients = @recipe.ingredients
    if @comment.save
      redirect_to recipe_path(@recipe) and return
    else
      render "recipes/show"

    end
  end

  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def comment_params
    params.require(:recipe_comment).permit(:text).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end
end

# def create
#   @comment = Comment.new(comment_params)
#   @prototype = @comment.prototype
#   if @comment.save
#     redirect_to prototype_path(@prototype)
#   else  
#     @comments = @prototype.comments.includes(:user)
#     render "prototypes/show"
#   end
