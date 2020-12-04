class Blog < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  has_rich_text :content
end
