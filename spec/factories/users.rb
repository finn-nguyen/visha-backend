FactoryGirl.define do
  factory :user do
    username Faker::Internet.user_name
    password '123456'
  end
end