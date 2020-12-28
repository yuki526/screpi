class RecipeComment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  validates_uniqueness_of :post_id, scope: :user_id
end
