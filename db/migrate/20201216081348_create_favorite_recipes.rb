class CreateFavoriteRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :favorite_recipes do |t|
      t.string :title,             null: false
      t.string :URL,               null: false
      t.integer :site_type_id,     null: false
      t.integer :effort_level_id,  null: false
      
      t.references :user,            null: false,  foreign_key: true
      t.references :recipe,          null: false,  foreign_key: true

      t.timestamps
    end
  end
end
