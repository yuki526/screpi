class Ingredient < ApplicationRecord
  has_many :recipe_ingredinents
  has_many :recipes, through: :recipe_ingredinents
end
