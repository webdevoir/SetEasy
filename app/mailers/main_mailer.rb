class MainMailer < ApplicationMailer

  def sample_email(user)
    @user = user
    mail(to: @user.email, subject: 'Sample Email')
  end

  def contact_me(message)
  	@greeting = "Hi"
  	@body = message.body
  	@email = message.email
  	@name = message.name
  	mail to: "info@seteasy.ca", from: "info@seteasy.ca"
  end

  def send_new_user_message(user)
    @user = user
    @email = user.email
    mail(to: user.email, subject: 'Welcome Aboard!', cc: 'info@seteasy.ca')
  end
end
