class RecipesController < ApplicationController
  before_action :authenticate, only: [:mypage, :new, :create]

  
  def index
    @new_videos = Recipe.where(site_type_id: 2).order("created_at DESC").limit(3)
    @new_recipes = Recipe.where.not(site_type_id: 2).order("created_at DESC").page(params[:page]).per(5)
  end
  
  def about
  end
  
  def mypage
  end

  def new
    @form_recipe_ingredient = FormRecipeIngredient.new
  end
  
  def create
    @form_recipe_ingredient = FormRecipeIngredient.new(recipe_params)
    unless @form_recipe_ingredient.valid?
      render :new
    else
      if @form_recipe_ingredient.site_type_id == 2
        @form_recipe_ingredient.url = @form_recipe_ingredient.url.last(11)
      end
      binding.pry
      @form_recipe_ingredient.save
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
    params.require(:form_recipe_ingredient).permit(:title, :url, :site_type_id, :effort_level_id, :content, name: []).merge(user_id: current_user.id)
  end

end
