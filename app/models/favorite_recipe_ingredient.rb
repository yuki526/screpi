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


  def self.set_favorite_recipe_ingredients(favorite_recipe, original_recipe)

    # 材料を一つずつ登録or既存データを取り出し、idを配列に格納
    ingredients_array = Array.new
    original_recipe.ingredients.each do |i|
      ingredient = i[:id]
      ingredients_array << ingredient
    end

    #中間テーブルにレコード作成
    ingredients_array.each do |i|
      FavoriteRecipeIngredient.create(favorite_recipe_id: favorite_recipe.id, ingredient_id: i)
    end
  end
end
