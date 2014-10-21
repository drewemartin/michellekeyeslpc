class Letter < ActiveRecord::Base

  before_create :format_number

  validates :name, :message, :email, :number, presence: true

  validate :email_must_have_symbols
  validate :number_must_be_valid

  private

  def format_number
    formatted_number = self.number
    if formatted_number[0] == '1'
      self.number = formatted_number.insert(1,'-').insert(5,'-').insert(9,'-')
    else
      self.number = formatted_number.insert(3,'-').insert(7,'-')
    end

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

      if number.length < 10 || number.length > 11 || (number[0] == '1' && number.length == 10) || (number[0] != '1' && number.length > 10) || number[0] == '0' || number.split('').any? { |char| char =~ /[A-Za-z]/ }
       errors.add(:number, 'must include existing non-extension number')
      end
    end
  end
end
