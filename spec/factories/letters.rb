# Read about factories at https://github.com/thoughtbot/factory_girl

require 'faker'

FactoryGirl.define do
  factory :letter do
    name Faker::Name.name
    email Faker::Internet.email
    number Faker::PhoneNumber.phone_number
    message "MyText"
    appointment (Time.now + 1.days)
  end
end
