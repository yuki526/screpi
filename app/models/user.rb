class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_many :recipes
  has_many :recipe_comments
  has_many :blog_comments
  has_many :favorite_recipes
  has_many :lists, dependent: :destroy
  has_many :ingredients, through: :lists
  has_many :likes
  has_many :liked_recipes, through: :likes, source: :recipe 

  with_options presence: true do
    validates :name, length: { maximum: 20 }
    validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/, message: 'は半角英数混合で入力してください' }
    validates :user_icon_id
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user_icon
end
