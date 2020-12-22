class BlogCommentsController < ApplicationController
  before_action :authenticate

  def create
    @comment = BlogComment.new(comment_params)
    @blog = Blog.find(params[:blog_id])
    @recipe = @blog.recipe
    binding.pry
    if @comment.save
      redirect_to recipe_blog_path(recipe_id: @recipe.id, blog_id: @blog.id) and return
    else
      render "blogs/show"
    end
  end

  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def comment_params
    params.require(:blog_comment).permit(:text).merge(user_id: current_user.id, blog_id: params[:recipe_id])
  end
end
