class Letter < ActiveRecord::Base

  before_save :format_number

  validates :name, :message, :email, :number, presence: true

  validate :email_must_have_symbols
  validate :number_must_be_valid

  private

  def format_number
    formatted_number = self.number 

  end

  def email_must_have_symbols
    unless email.nil?

      if email.split('').include?('@') == false || email.split('').include?('.') == false
        errors.add(:email, 'must include @ symbol and period')
      end 

    end  
  end

  def number_must_be_valid
    unless number.nil?

      test_val = number.gsub(/[^0-9A-Za-z]/, '').delete!'a-z '

      if test_val.length < 10 || test_val.length > 11 || (test_val[0] == '1' && test_val.length == 10)
       errors.add(:number, 'must include existing non-extension number')
      end
    end
  end
end
