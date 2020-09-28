class UserMailer < ApplicationMailer
  include SendGrid
  
  def welcome_email(user)
    @user = user
    mail(
      to: @user.email,
      subject: 'Thanks for joining Odin Facebook!'
    )
  end
end
