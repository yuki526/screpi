class RenameUrlColumnToFavoriteRecipes < ActiveRecord::Migration[6.0]
  def change
    rename_column :favorite_recipes, :URL, :url
  end
end
