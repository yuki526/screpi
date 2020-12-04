class BlogsController < ApplicationController
  before_action :authenticate, only: [:new, :create]


  def new
    @blog = Blog.new
    @recipe = Recipe.find(params[:recipe_id])
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to mypage_recipe_path(current_user)
    else
      render :new
    end

  end


  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def blog_params
    params.require(:blog).permit(:title, :content).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end

end
