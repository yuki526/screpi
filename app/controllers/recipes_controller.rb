class RecipesController < ApplicationController
  before_action :authenticate, only: [:mypage, :new, :create]

  
  def index
    @new_recipes = Recipe.order("created_at DESC").limit(10)
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
    if @recipe.save
      redirect_to root_path and return
    else
      render :new
    end
  end

  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def recipe_params
    params.require(:recipe).permit(:title, :URL, :site_type_id, :effort_level_id, :content).merge(user_id: current_user.id)
  end

end
