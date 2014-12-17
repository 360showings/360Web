# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  agent_id     :integer
#  bio          :text
#  website      :string(255)
#  facebook     :string(255)
#  license      :string(255)
#  designations :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# CHARTER
#   Store additional information for agents, for extended branding
#
# USAGE
#
# NOTES AND WARNINGS
#
class Profile < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :agent
  
  validates :website, :format => { with: URL_REGEX }, :allow_blank => true
  validates :facebook, :format => { with: FACEBOOK_REGEX }, :allow_blank => true
end
