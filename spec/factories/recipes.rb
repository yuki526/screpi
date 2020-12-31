FactoryBot.define do
  factory :recipe do
    title { 'test-title' }
    url { 'https://testurl.com' }
    site_type_id { 3 }
    effort_level_id { 3 }
    
  end
end