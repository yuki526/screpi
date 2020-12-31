class Ingredient < ApplicationRecord
  has_many :recipe_ingredinents
  has_many :recipes, through: :recipe_ingredinents

  has_many :favorite_recipes, through: :favorite_recipe_ingredinents
  has_many :favorite_recipe_ingredinents

  has_many :lists
  has_many :users, through: :lists

  with_options presence: true do
    validates :name, length: { maximum: 10 }
  end



  private

  def self.search(search)
    ingredient = Ingredient.where('name LIKE(?)', "%#{search}%")
    return ingredient
  end
end
