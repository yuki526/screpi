FactoryBot.define do
  factory :form_recipe_ingredient do
    title { 'test-title' }
    url { 'https://testurl.com' }
    site_type_id { 3 }
    effort_level_id { 3 }
    content { 'テスト内容テスト内容テスト内容テスト内容テスト内容テスト内容' }
    name { 'にんじん、じゃがいも、玉ねぎ'}
    
  end
end
