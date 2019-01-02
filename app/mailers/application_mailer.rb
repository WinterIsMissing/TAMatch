class ApplicationMailer < ActionMailer::Base
  default from: 'donotreply@TAnder.com'



  def login_email(user,token)
    @userEmail = user # this is the email
    @token = token.to_s # This is the login link
    mail(to: @userEmail, subject: 'Welcome to Tander')
  end
end
