class SearchesController < ApplicationController

  def result
    @keyword = params[:keyword]
    if @keyword != ""
      @recipes = Recipe.search(@keyword)
      # @ingredients = Ingredient.search(@keyword)
    else
      redirect_to root_path
    end
  end


end
