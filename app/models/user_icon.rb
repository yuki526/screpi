class UserIcon < ActiveHash::Base
  self.data = [
    { id: 1, name: 'far fa-smile'},      # smile
    { id: 2, name: 'fas fa-apple-alt'},  # apple
    { id: 3, name: 'fas fa-carrot'},     # carrot
    { id: 4, name: 'fas fa-fish'},       # fish
    { id: 5, name: 'fas fa-mug-hot'},    # mug
    { id: 6, name: 'fas fa-pepper-hot'}  # pepper
  ]

  include ActiveHash::Associations
    has_many :users
end
