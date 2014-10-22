class Letter < ActiveRecord::Base

  before_create :format_number

  validates :name, :message, :email, :number, presence: true

  validate :email_must_have_symbols
  validate :number_must_be_valid
  validate :appointment_must_not_request_past_time

  private

  def format_number
    formatted_number = self.number.gsub(/[^0-9]/, '')
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
      test_val = number.gsub(/[^0-9A-Za-z]/, '')

      if test_val.length < 10 || test_val.length > 11 || (test_val[0] == '1' && test_val.length == 10) || (test_val[0] != '1' && test_val.length > 10) || test_val[0] == '0' || test_val.split('').any? { |char| char =~ /[A-Za-z]/ }
       errors.add(:number, 'must be valid and not include an extention')
      end
    end
  end

  def appointment_must_not_request_past_time
    unless appointment.nil?

      if appointment < Time.now
        errors.add(:appointment, 'must be scheduled for an upcoming time')
      end
      
    end
  end
end


