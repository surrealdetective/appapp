class UserMailer < ActionMailer::Base
  default :from => "appapp@flatironschool.com"
  
  #EMAILS TO APPLICANTS
  # this method will send an email to the user once the user has signed up for the site
  def welcome_email(user)
    @user = user
    @url  = 'http://www.google.com'
    @user.password
    
    mail(:to => @user.email, :subject => 'Welcome to AppApp!', :body => "Your login is #{@user.email}. Your password is #{@user.password}. \
      Also, if you'd like to get started coding, you can look through the Flatiron pre-work at http://prework.flatironschool.com. Enjoy!")
  end

  def interview_email(user)
    @user = user
    mail(:to => @user.email, :subject => "We'd like to interview you", :body => "Hi #{@user.first_name}, \n We would like to interview you. Please pick a time for your interview at http://localhost:3000/dossiers/#{@user.last_dossier.id}/schedule. Thanks!")
  end

  #there needs to be a view dedicated to the 2nd interview.
  def code_email(user)
    @user = user

    mail(:to => @user.email, :subject => "Get ready to code!", :body => "Hi #{@user.first_name}, \n \
      You made it to the next stage in the interviewing process! Now we'd like you to solve a code puzzle as part of the application process. \
      I'd like you to write a program that simulates a simple game that we all know and love - tic tac toe. \
      You are allowed to write it in any language you want, but we prefer Ruby or Javascript. \
      You're allowed to use outside resources, but you're not allowed to copy code. \n Good luck! \n \
      Please schedule an interview with us so we can review your code together. Arrange the interview at http://localhost:3000/dossiers/#{@user.last_dossier.id}/schedule. Thanks!")
  end

  #user is rejected, deferred, or accepted
  def rejected_email(user)
    @user = user

    mail(:to => @user.email, :subject => "Thank you for your interest in Flatiron School", :body => "Hi #{@user.first_name}, \n \
      Thanks for your interest in Flatiron School. Unfortunately, we are no longer accepting applicants for #{@user.last_dossier.semester}. \
      Please continue the pre-work and apply again next semester or for a different class!")
  end

  def deferred_email(user)
    @user = user

    mail(:to => @user.email, :subject => "Thank you for your interest in Flatiron SChool", :body => "Hi #{@user.first_name}, \n \
      Thank you for your interest in Flatiron School. We really like you as a candidate, and we'd like to put you in a later class. \
      Unfortunately, we are no longer accepting students for #{@user.last_dossier.semester}. Please keep in touch and let us know \
      if you're still interested!")
  end

  def accepted_email(user)
    @user = user

    mail(:to => @user.email, :subject => "Congratulations! You've been accepted to Flatiron School", :body => "Congratulations! \
      We look forward to seeing you for #{@user.last_dossier.semester}. Please remember to send us the initial payment \
      by #{@user.last_dossier.course.starting_date}.")  
  end

  def accepted_clothes_email(user)
    @user = user

    mail(:to => @user.email, :subject => "Flatiron Cred", :body => "Please let us know your shirt size. Thanks!")  
  end

  #user gets an email after paying
  def confirmed_email(user)
    @user = user

    mail(:to => @user.email, :subject => "We received your deposit.", :body => "Hi #{@user.first_name}, \n \
      We are super excited to see you for #{@user.last_dossier.semester}. We've reserved your spot!") 
  end

  def full_payment_email(user)
    @user = user

    mail(:to => @user.email, :subject => "We received your payment.", :body => "Hi #{@user.first_name}, \n \
      We got your second payment for #{@user.last_dossier.semester}. Looking forward to seeing you soon!") 
  end

  def reminder_email(receiver)
    @user = receiver

    mail(:to => @user.email, :subject => "Remember to sign up for a Flatiron interview!", :body => "Hi #{@user.first_name}, \n \
      We're really excited about interviewing you. Please remember to sign up for an interview time at http://localhost:3000/dossiers/#{@user.last_dossier.id}/schedule!")    
  end

  def reschedule_email(receiver)
    @user = receiver

    mail(:to => @user.email, :subject => "Reschedule your Flatiron interview!", :body => "Hi #{@user.first_name}, \n \
      We're really excited about interviewing you. Please sign up for your interview time at http://localhost:3000/dossiers/#{@user.last_dossier.id}/schedule!")    
  end


  #EMAILS TO ADMIN

  #adam sends an email to avi
  def message_email(receiver, sender)
        
  end

end

#make these methods
#When prework is 100% completed, send an email
#when count of 15 new applicants reaches some amount, send an email
#When interviews per week is lower than 3.
#
#When comment is made, send email to @avi.
#Class is now 50% full.
#


