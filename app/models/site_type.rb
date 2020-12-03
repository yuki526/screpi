class SiteType < ActiveHash::Base
  self.data = [
    { id: 1, name '--'},
    { id: 2, name 'youtube'},
    { id: 3, name 'other'}
  ]
end
