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
      ingredient = Ingredient.where('name Like ?', "#{@keyword}")
      if ingredient.empty?
        @recipes = nil
      else
        ids = RecipeIngredient.where(ingredient_id: ingredient[0].id)
        @recipes = Array.new
        ids.each do |id|
          recipe = Recipe.find(id.recipe_id)
          @recipes << recipe
        end
      end
    else
      redirect_to searches_path
    end

  end


end
