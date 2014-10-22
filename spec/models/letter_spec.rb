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

    it 'should not have a number w/ any letters' do
      expect(FactoryGirl.build(:letter, number:'2813308004d')).to_not be_valid
    end

    it 'should not have a number w/ too few digits' do
      expect(FactoryGirl.build(:letter, number:'281330800')).to_not be_valid
    end

    it 'should not have too many digits' do
      expect(FactoryGirl.build(:letter, number:'281330800411')).to_not be_valid
    end

    it 'should not have a number that starts with zero' do
      expect(FactoryGirl.build(:letter, number:'02813308004')).to_not be_valid
    end

    it 'should not have a number that starts with zero' do
      expect(FactoryGirl.build(:letter, number:'0281330800')).to_not be_valid
    end

    it 'should permit correct, preformatted numbers with dashes' do
      expect(FactoryGirl.build(:letter, number:'281-330-8004')).to be_valid
    end

    it 'should permit correct, preformatted numbers with dashes' do
      expect(FactoryGirl.build(:letter, number:'1-281-330-8004')).to be_valid
    end

    it 'should permit correct, preformatted numbers with dashes' do
      expect(FactoryGirl.build(:letter, number:'1-281-330-8004')).to be_valid
    end

    it 'should not accept appointments from the past' do
      expect(FactoryGirl.build(:letter, appointment:(Time.now - 1.seconds))).to_not be_valid
    end

  end

end

# name Faker::Name.name
# email Faker::Internet.email
# number Faker::PhoneNumber.phone_number
# message "MyText"
# appointment "2014-10-20 11:55:33"
# 281-330-8004
# 2813308004



Time.new(Time.now.year,Time.now.month,Time.now.hour,Time.now.min,Time.now.sec)
Time.new(2014,11,x,5,55)
