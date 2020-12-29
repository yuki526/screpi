FactoryBot.define do
  factory :user do
    email { 'test@test.com' }
    password { 'qwer1234' }
    password_confirmation { 'qwer1234' }
    name { 'testname' }
    user_icon_id { 3 }
    
  end
end
