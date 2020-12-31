class RecipeComment < ApplicationRecord
  belongs_to :recipe
  belongs_to :user

  with_options presence: true do
    validates :text, length: { maximum: 100 }
  end
  
end
