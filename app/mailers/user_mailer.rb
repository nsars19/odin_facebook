class UserMailer < ApplicationMailer
  include SendGrid
  
  def welcome_email
    @user = params[:user]
    subject = 'Thanks for joining Odin Facebook!'
    from = Email.new(email: 'welcome@odin_facebook.com')
    to = Email.new(email: @user.email)
    email_content = "Thanks for joining Odin Facebook, #{@user.name}! We hope you have a great time!"
    content = Content.new(type: 'text/plain', value: email_content)
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').pots(request_body: mail.to_json)
  end
end
