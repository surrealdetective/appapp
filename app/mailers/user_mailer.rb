class UserMailer < ActionMailer::Base
  default :from => "appapp@flatironschool.com"
  # this method will send an email to the user once the user has signed up for the site
  def welcome_email(user)
    @user = user
    @url  = 'http://www.google.com'
    @user.password
    
    mail(:to => @user.email, :subject => 'Welcome to AppApp!', :body => "Your login is #{@user.email}. Your password is #{@user.password}. Also, if you'd like to get started coding, you can look through the Flatiron pre-work at http://prework.flatironschool.com. Enjoy!")
  end

  def message_email(receiver, sender)
        
  end

  #send when button is pressed, "needs code interview"
  #also, another state for 2nd interview is needed, so... they need to make a github, submit their code, and have it in a gist.

  #there needs to be a view dedicated to the 2nd interview.
  def code_email(user)
    @user = user

    mail(:to => @user.email, :subject => "Get ready to code!", :body => "Hi #{@user.first_name}, /n You made it to the next stage in the interviewing process! Now we'd like you to solve a code puzzle as part of the application process. I'd like you to write a program that simulates a simple game that we all know and love - tic tac toe. You are allowed to write it in any language you want, but we prefer Ruby or Javascript. You're allowed to use outside resources, but you're not allowed to copy code. /n Good luck!")
  end

  def accepted_email(user)
    @user = user

    mail(:to => @user.email, :subject => "Congratulations! You've been accepted to Flatiron School", :body => "Congratulations! We look forward to seeing you for #{@user.last_dossier.semester}. Please remember to send us the initial payment by #{@user.last_dossier.course.starting_date}.")  
  end

   def code_email(user)
    @user = user

    mail(:to => @user.email, :subject => "Get ready to code!", :body => "Hi #{@user.first_name}, /n You made it to the next stage in the interviewing process! Now we'd like you to solve a code puzzle as part of the application process. I'd like you to write a program that simulates a simple game that we all know and love - tic tac toe. You are allowed to write it in any language you want, but we prefer Ruby or Javascript. You're allowed to use outside resources, but you're not allowed to copy code. /n Good luck!")
  end

  #methods we want for the user
  #1. welcome-email = prework email - go to these things to sign up for the prework
  #2. @avi - "check this out" from a comment
  #3. code email - puzzle for whenever
  #4. accepted so signup to techie social networks email -
  #
  #user story: Signs up and receives email. 
  #gets reviewed and receives email to setup an interview
  #rejected email
  #deferred email
  

end




# #Hi Alex,

# Welcome to the Flatiron School!

# With the summer quickly approaching, it's time to get cracking :)

# First off, here's a short student survey. Please try to fill this out as soon as you get a chance so we can start planning.

# http://flatironschool.wufoo.com/forms/flatiron-school-student-survey-summer-2013/

# Next, you now have a Flatiron Email alias at firstname.lastname@flatironschool.com. Send some test emails to yourself and make sure that works.

# The pre-work for the semester is available at http://prework.flatironschool.com

# A large part of the work uses resources from Treehouse and CodeSchool - you should have received invites to both at your Flatiron School address.

# That's it for now. We're so excited to start learning with you in June! Email us any questions you have along the way. We'll be in touch with more details soon.

# See you soon!

# Flatiron Team.



