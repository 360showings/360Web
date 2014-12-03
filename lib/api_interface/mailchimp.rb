require 'singleton'

# CHARTER
#   Manage MailChimp lists; general goal is to keep the MailChimp master list in sync with 360 Showings users
#
# USAGE
#   Call methods on the MailChimp.instance (e.g., MailChimp.instance.sync_master_list)
#   THIS CAUSES MAILCHIMP TO SEND EMAILS
#
# NOTES AND WARNINGS
#   Uses the Gibbon gem and MailChimp API key for accessing the 360 Showings MailChimp account
#   Essentially Gibbon passes through API requests, translating options and wrapping the actual POST commands
#     So we're accessing the MailChimp 2.0 API pretty much directly, but without having to deal with web request details
#   The API for creating lists was removed in 2.0, so that has to be done through the web. 
#     Forms and emails can be extensively customized in MailChimp (I already added the logo header.)
#
#  SUBSCRIBING PEOPLE TO MAILCHIMP WILL SEND THEM WELCOME EMAILS!
#    So don't call sync_master_list on a populated user list unless you intend to do that
#    If you sync after the welcome email has been sent -- but before they confirm -- it will send them another welcome email
class Mailchimp
  include Singleton
  
  # These have to match the name of the lists in MailChimp. 
  #   Campaigns in MailChimp use lists; you can then use segments and groups for more specific targeting
  MASTER_LIST_NAME = 'Candidates'
  
  # Allow read-only access to client to expose full Gibbon interface to callers
  attr_accessor :client
  
  def update_email(old_email, new_email)
    id = get_list_id(MASTER_LIST_NAME)
    
    if id.nil?
      Rails.logger.info('Master Mailchimp list not found')
    else
      result = self.client.lists.subscribe(:id => id, 
                                           :email => {:email => old_email}, 
                                           :merge_vars => {'new-email' => new_email}, 
                                           :update_existing => true)
      if result.has_key?('error')
        raise result['error']
      end
    end    
  end
  
  def sync_master_list
    # Find the id of the master list (or nil if it's not there)
    id = get_list_id(MASTER_LIST_NAME)
    
    if id.nil?
      Rails.logger.info('Master Mailchimp list not found')
    else
      begin
        # This call can take a while; temporarily increase the timeout
        Gibbon::API.timeout = MAILCHIMP_UPDATE_TIMEOUT
        
        # Get "unsubscribed" users so that we don't add them back in
        # Note that the API will prevent this anyway, but no sense trying when we know it will generate an error
        unsubscribed = get_unsubscribed_list(id)

        # Update all users in batches. (Just in case we someday have thousands of users.)
        Candidate.find_in_batches(:batch_size => USER_BATCH_SIZE) do |batch| 
          batch_data = []
          # Prepare batch to upload to MailChimp
          #   Merge variables have to match what's defined in MailChimp
          batch.each do |u| 
            batch_data.push({:EMAIL => {:email => u.email}, :merge_vars => {:FNAME => u.first_name, :LNAME => u.last_name}}) unless unsubscribed.include?(u.email)
          end
        
          if batch_data.empty?
            Rails.logger.info('No new users to subscribe')
          else
            batch_result = self.client.lists.batch_subscribe({:id => id,
                                                              :batch => batch_data,
                                                              :double_optin => DOUBLE_OPTIN_POLICY,
                                                              :update_existing => true})
            # Logs "adds", "updates", and "errors" (e.g., an error would be if they're unsubscribed and you try to add them again)
            Rails.logger.info(batch_result.inspect)
          end
        end
      ensure
        Gibbon::API.timeout = MAILCHIMP_DEFAULT_TIMEOUT
      end
    end
  end
  
private
  def initialize
    # Reads keys and such from the initializer
    @client = Gibbon::API.new
  end
  
  # Return a list of emails of people who manually unsubscribed (e.g., by clicking on the unsubscribe link, or unsubscribed by admins)
  def get_unsubscribed_list(id)
    unsubscribed = self.client.lists.members({:id => id, :status => "unsubscribed"})
    # This does not return an 'errors' field
    
    0 == unsubscribed['total'] ? [] : unsubscribed['data'].map { |d| d['email'] }
  end
  
  # Return the list id (key for subsequent calls)
  # Will raise a RuntimeError if fetching the list fails
  def get_list_id(list_name)
    # returns a hash with total/data/errors
    list = self.client.lists.list({:filters => {:list_name => list_name}})
    
    raise list['errors'].join(',') if !list['errors'].empty?
    
    1 == list['total'] ? list['data'].first['id'] : nil
  end  
end
