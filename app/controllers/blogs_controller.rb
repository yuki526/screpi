class BlogsController < ApplicationController
  before_action :authenticate, only: [:new, :create, :destroy]


  def new
    @blog = Blog.new
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to mypage_recipe_path(current_user.id)
    else
      @blog = Blog.new
      @recipe = Recipe.find(params[:recipe_id])
      render :new
    end
  end

  def show
    @blog = Blog.find(params[:id])
    @recipe = Recipe.find(params[:recipe_id])
    @comment = BlogComment.new
    @comments = BlogComment.where(blog_id: @blog.id).order("created_at DESC")
  end

  def destroy
    blog = Blog.find(params[:id])
    blog.destroy
    redirect_to mypage_recipe_path(current_user.id)
  end


  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def blog_params
    params.require(:blog).permit(:title, :content).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end

end
