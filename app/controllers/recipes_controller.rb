class RecipesController < ApplicationController
  before_action :authenticate, only: [:mypage, :new, :create]

  
  def index
    @new_videos = Recipe.where(site_type_id: 2).order("created_at DESC").limit(10)
    @new_recipes = Recipe.where.not(site_type_id: 2).order("created_at DESC").limit(10)
  end
  
  def about
  end
  
  def mypage
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    unless @recipe.valid?
      render :new
    else
      if @recipe.site_type_id == 2
        @recipe.URL = @recipe.URL.last(11)
      end
      @recipe.save
      redirect_to root_path and return
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def recipe_params
    params.require(:recipe).permit(:title, :URL, :site_type_id, :effort_level_id, :content).merge(user_id: current_user.id)
  end

end
