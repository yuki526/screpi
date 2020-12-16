class FavoriteRecipesController < ApplicationController
  before_action :authenticate

  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredients = @recipe.ingredients
    @form_recipe_ingredient = FormRecipeIngredient.new
  end

  def create
  end

  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

  def favorite_recipe_params
    params.require(:form_recipe_ingredient).permit(:title, :url, :site_type_id, :effort_level_id, :content, name: []).merge(user_id: current_user.id, recipe_id: params[:recipe_id])
  end

  def ingredients_split
    params[:form_recipe_ingredient][:name] = params[:form_recipe_ingredient][:name].split("、")
  end

end
