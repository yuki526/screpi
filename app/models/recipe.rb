class Recipe < ApplicationRecord
  belongs_to :user
  has_many :blogs, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :favorite_recipes
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user 

  has_rich_text :content

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :site_type
  belongs_to :effort_level



  def self.search(search)
    recipes = Recipe.where('title LIKE(?)', "%#{search}%")
    return recipes
  end

  def self.find_recipes_by_ingredients(recipe_ingredient_ids)
    recipes = Array.new
      recipe_ingredient_ids.each do |id|
        recipe = Recipe.find(id.recipe_id)
        recipes << recipe
      end
    return recipes
  end

end
