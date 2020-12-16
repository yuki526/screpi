class FavoriteRecipeIngredient < ApplicationRecord
  belongs_to :favorite_recipe
  belongs_to :ingredient
end
