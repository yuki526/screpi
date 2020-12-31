class FavoriteRecipe < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients

  has_rich_text :content

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :site_type
  belongs_to :effort_level

  with_options presence: true do
    validates :title, length: { maximum: 20 }
    validates :url
    validates :site_type_id
    validates :effort_level_id
  end


  def set_favorite_recipe(favorite_recipe, original_recipe, current_user_id)

    # 各項目をセット（素材以外）
    favorite_recipe.title = original_recipe.title
    favorite_recipe.url = original_recipe.url
    favorite_recipe.site_type_id = original_recipe.site_type_id
    favorite_recipe.recipe_id = original_recipe.id
    favorite_recipe.user_id = current_user_id

    return favorite_recipe
  end

end

