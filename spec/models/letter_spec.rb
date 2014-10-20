require 'rails_helper'

describe Letter do
  context 'before creations' do

    it 'should have a valid factory' do
      letter = FactoryGirl.build(:letter)
      expect(letter).to be_valid
    end

    it 'should not accept an empty name' do
      expect(FactoryGirl.build(:letter, name:nil)).to_not be_valid
    end

    it 'should not have an empty message' do
      expect(FactoryGirl.build(:letter, message:nil)).to_not be_valid
    end

    it 'should not have an empty email' do
      expect(FactoryGirl.build(:letter, email:nil)).to_not be_valid
    end

    it 'should not have an email w/out @ symbol' do
      expect(FactoryGirl.build(:letter, email:'bob.com')).to_not be_valid
    end

    it 'should not have an email w/out @ symbol' do
      expect(FactoryGirl.build(:letter, email:'bob@com')).to_not be_valid
    end

    it 'should not have an empty number' do
      expect(FactoryGirl.build(:letter, number:nil)).to_not be_valid
    end

    it 'should not have a number w/ too many digits' do
      expect(FactoryGirl.build(:letter, number:'1-610-610-6100-0')).to_not be_valid
    end

    it 'should not have a number w/ too few digits' do
      expect(FactoryGirl.build(:letter, number:'1-610-610-61')).to_not be_valid
    end

    it 'should not have a number w/ too few digits' do
      expect(FactoryGirl.build(:letter, number:'1-610-610-61   ')).to_not be_valid
    end

  end

end

# name Faker::Name.name
# email Faker::Internet.email
# number Faker::PhoneNumber.phone_number
# message "MyText"
# appointment "2014-10-20 11:55:33"