class UserMailer < ActionMailer::Base
  default from: ApplicationHelper::MAILER_FROM_ADDRESS
  
  def welcome_email(candidate)
    @name = candidate.first_name
    
    mail(:to => candidate.email, :bcc => ApplicationHelper::SHOWINGS_ADMIN, :subject => 'Welcome to 360 Showings!')  
  end
  
  def comment_email(category, comment)
    @category = category
    @comment = comment
    
    mail(:to => ApplicationHelper::SHOWINGS_ADMIN, :subject => "360 Showings contact form - #{@category}")
  end
end
