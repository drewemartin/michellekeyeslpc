class GuestMailer < ActionMailer::Base
  default from: "drew.e.martin@gmail.com"

  def send_to_admin(letter)
    @letter = letter

    mail(to: 'drew.e.martin@gmail.com', 
      subject: "#{@letter.name} emailed you from your site")
  end
end
