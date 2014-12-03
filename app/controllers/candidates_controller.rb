class CandidatesController < ApplicationController
  # POST /candidates/interested
  def interested
    if params[:email].blank?
      redirect_to root_path, :alert => 'Please provide an Email!'
    else
      #c = Candidate.new(:email => params[:email], :first_name => params[:first_name], :last_name => params[:last_name])
      c = Candidate.new(params.slice(:email, :first_name, :last_name))
      puts c.inspect
      if c.save
        UserMailer.welcome_email(c).deliver
        
        redirect_to root_path, :notice => I18n.t('signup_thanks')
      else
        redirect_to root_path, :alert => c.errors.full_messages.uniq.to_sentence
      end
    end
  end
end
