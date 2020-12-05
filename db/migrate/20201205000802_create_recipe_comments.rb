class CreateRecipeComments < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_comments do |t|
      t.text :text,       null:false
      t.references :user,  null:false, foreign_key: true
      t.references :recipe,  null:false, foreign_key: true

      t.timestamps
    end
  end
end
