# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Municipal::Application.initialize!

ActionMailer::Base.smtp_settings = { 
  :address => 'mail.perk.es',
  :domain  => 'perk.es',
  :port      => 587, 
  :user_name => ApplicationHelper::SMTP_USERNAME,
  :password => ApplicationHelper::SMTP_PASSWORD, 
  :authentication => :plain,
  :enable_starttls_auto => true,
  # Remove this when the cert is there!
  :openssl_verify_mode  => 'none'
} 
