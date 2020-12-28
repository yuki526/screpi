class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates_uniqueness_of :recipe_id, scope: :user_id

  # def already_liked?(recipe)
  #   self.likes.exists?(recipe_id: recipe.id)
  # end

end
