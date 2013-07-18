ActionMailer::Base.smtp_settings = {
  # so we're committing our password.... lol
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "appappflatiron",
  :password             => "smoothiemachine",
  :authentication       => "plain",
  :enable_starttls_auto => true
}