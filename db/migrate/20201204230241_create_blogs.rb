class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :title,        null: false
      t.references :user,     null: false, foreign_key: true
      t.references :recipe,   null: false, foreign_key: true

      t.timestamps
    end
  end
end
