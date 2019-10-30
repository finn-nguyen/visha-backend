FactoryGirl.define do
  factory :video do
    title Faker::App.name
    description Faker::Lorem.word
    views Faker::Number.between(from: 100, to: 1000)
    link Faker::Internet.domain_name
    user 
  end
end