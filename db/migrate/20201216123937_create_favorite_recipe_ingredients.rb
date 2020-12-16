class CreateFavoriteRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_recipe_ingredients do |t|
      t.references :favorite_recipe, foreign_key: true
      t.references :ingredient, foreign_key: true

      t.timestamps
    end
  end
end
