# == Schema Information
#
# Table name: listings
#
#  id         :integer          not null, primary key
#  agent_id   :integer
#  mls_num    :integer          not null
#  address_1  :string(255)
#  address_2  :string(255)
#  city       :string(255)
#  state      :string(2)
#  zipcode    :string(10)
#  created_at :datetime
#  updated_at :datetime
#

# CHARTER
#   Represent an agent's listing. Point to the MLS, give address information, etc.
#
# USAGE
#
# NOTES AND WARNINGS
#   This assumes all listings are by agents, through an MLS. It doesn't allow pocket listings or FSBOs.
# If we want to allow this, remove the MLS_ID requirement, and maybe we'd need a new kind of user.
#
class Listing < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :agent
  has_many :contents, :dependent => :destroy
  
  validates :mls_num, :numericality => { :only_integer => true, :greater_than => 0 }
  validates :state, :inclusion => { in: US_STATES }, :allow_blank => true
  validates :zipcode, :format => { with: US_ZIP_REGEX }, :allow_blank => true
end
