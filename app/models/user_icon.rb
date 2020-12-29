class UserIcon < ActiveHash::Base
  self.data = [
    { id: 1, name: '--'},
    { id: 2, name: 'far fa-smile'},      # smile
    { id: 3, name: 'fas fa-apple-alt'},  # apple
    { id: 4, name: 'fas fa-carrot'},     # carrot
    { id: 5, name: 'fas fa-fish'},       # fish
    { id: 6, name: 'fas fa-mug-hot'},    # mug
    { id: 7, name: 'fas fa-cat'}         # cat
  ]

  include ActiveHash::Associations
    has_many :users
end
