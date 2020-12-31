class Blog < ApplicationRecord
  belongs_to :recipe
  belongs_to :user
  has_many :blog_comments, dependent: :destroy
  
  has_rich_text :content
  validates_associated :content

  with_options presence: true do
    validates :title, length: { maximum: 20 }
    validates :content
  end
end
