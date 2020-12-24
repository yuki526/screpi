class FavoriteRecipeIngredient < ApplicationRecord
  belongs_to :favorite_recipe
  belongs_to :ingredient

  def self.set_ingredient(recipe)
    @ingredients_id = FavoriteRecipeIngredient.where(favorite_recipe_id: recipe.id)
    names = Array.new
    @ingredients_id.each do |id|
      ingredient_name = Ingredient.find(id.ingredient_id)
      names << ingredient_name
    end
    names
  end
end
