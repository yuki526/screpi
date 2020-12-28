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

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user_icon
end
