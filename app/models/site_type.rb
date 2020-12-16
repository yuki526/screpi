class SiteType < ActiveHash::Base
  self.data = [
    { id: 1, name: '--'},
    { id: 2, name: 'youtube'},
    { id: 3, name: 'クラシル'},
    { id: 4, name: 'DELISH KITCHEN'},
    { id: 5, name: 'Nadia'},
    { id: 6, name: 'オレンジページ.net'},
    { id: 7, name: '白ごはん.com'},
    { id: 8, name: 'みんなのきょうの料理'},
    { id: 9, name: 'レタスクラブ'},
    { id: 10, name: 'つくおき'},
    { id: 11, name: 'その他'}
  ]

  include ActiveHash::Associations
    has_many :recipes
    has_many :favorite_recipes
end
