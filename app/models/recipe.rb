class Recipe < ApplicationRecord
  belongs_to :user
  has_many :blogs, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :recipe_ingredinents, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredinents

  has_rich_text :content

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :site_type
  belongs_to :effort_level
end
