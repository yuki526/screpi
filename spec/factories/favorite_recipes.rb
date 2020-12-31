FactoryBot.define do
  factory :favorite_recipe do
    title { 'test-title' }
    url { 'https://testurl.com' }
    site_type_id { 3 }
    effort_level_id { 3 }
    content { 'テスト内容テスト内容テスト内容テスト内容テスト内容テスト内容' }
    
  end
end
