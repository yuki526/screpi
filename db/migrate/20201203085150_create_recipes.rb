class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :title,             null: false
      t.string :URL,               null: false
      t.integer :site_type_id,     null: false
      t.integer :effort_level_id,  null: false
      
      t.references :user,          null: false,  foreign_key: true

      t.timestamps
    end
  end
end
