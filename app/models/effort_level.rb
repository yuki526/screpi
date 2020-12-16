class EffortLevel < ActiveHash::Base
  self.data = [
    { id: 1, name: '--'},
    { id: 2, name: '☆'},
    { id: 3, name: '☆☆'},
    { id: 4, name: '☆☆☆'},
    { id: 5, name: '☆☆☆☆'},
    { id: 6, name: '☆☆☆☆☆'}
  ]

  include ActiveHash::Associations
    has_many :recipes
    has_many :favorite_recipes
end
