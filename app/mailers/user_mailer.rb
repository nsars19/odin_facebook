class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Thanks for joining Odin Facebook!")
  end
end
