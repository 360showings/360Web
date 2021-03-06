class StaticPagesController < ApplicationController
  def home
  end
  
  def about
  end
  
  def contact
    @categories = ['Question', 'Comment', 'Bug Report', 'Feature Request', 'Other']
  end
  
  def legal
  end
  
  def privacy
  end

  def comment
    if simple_captcha_valid?  
      if params[:content].strip.blank?
        redirect_to contact_path, :alert => 'Please enter a comment'      
      else
        UserMailer.comment_email(params[:category], params[:content]).deliver
        
        redirect_to root_path, :notice => 'Thanks for your comment!'
      end
    else
      redirect_to contact_path, :alert => 'Invalid Captcha; please try again!'
    end
  end
end
