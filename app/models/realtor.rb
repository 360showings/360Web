# == Schema Information
#
# Table name: realtors
#
#  id           :integer          not null, primary key
#  multilist_id :integer
#  first_name   :string(255)      not null
#  last_name    :string(255)      not null
#  agent_code   :string(255)
#  office_code  :string(8)
#  email        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Realtor < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :multilist
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates :email, :uniqueness => { case_sensitive: false },
                    :format => { with: EMAIL_REGEX },
                    :allow_nil => true
  validates :office_code, :length => { :maximum => MLS_ID_LEN }     
end
