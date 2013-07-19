class UserMailer < ActionMailer::Base
  default :from => "appapp@flatironschool.com"
  # this method will send an email to the user once the user has signed up for the site
  def welcome_email(user)
    @user = user
    @url  = 'http://www.google.com'
    
    mail(:to => @user.email, :subject => 'Welcome to AppApp!')
  end

end





