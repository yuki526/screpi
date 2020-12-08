class RenameUrlColumnToRecipes < ActiveRecord::Migration[6.0]
  def change
    rename_column :recipes, :URL, :url
  end
end
