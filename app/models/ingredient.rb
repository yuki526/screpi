class Ingredient < ApplicationRecord
  has_many :recipe_ingredinents
  has_many :recipes, through: :recipe_ingredinents

  has_many :favorite_recipes, through: :favorite_recipe_ingredinents
  has_many :favorite_recipe_ingredinents

  has_many :lists
  has_many :users, through: :lists

  def self.search(search)
    recipes = Ingredient.where('name LIKE(?)', "%#{search}%").includes(:recipe)
    return recipes
  end
end
