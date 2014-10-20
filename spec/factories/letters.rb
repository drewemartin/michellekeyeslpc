# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :letter do
    name "MyString"
    email "MyString"
    number "MyString"
    message "MyText"
    appointment "2014-10-20 11:55:33"
  end
end
