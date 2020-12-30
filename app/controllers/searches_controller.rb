class SearchesController < ApplicationController

  def result
    @keyword = params[:keyword]
    if @keyword != ""
      @recipes = Recipe.search(@keyword)
    else
      redirect_to root_path
    end
  end

  def ingredient
    @keyword = params[:keyword]
    if @keyword != ""
      ingredient = Ingredient.search(@keyword)
      if ingredient.empty?
        @recipes = nil and return
      else
        ids = RecipeIngredient.where(ingredient_id: ingredient[0].id)
        @recipes = Recipe.find_recipes_by_ingredients(ids)
      end
    else
      redirect_to searches_path
    end

  end


end
