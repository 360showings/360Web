# == Schema Information
#
# Table name: offices
#
#  id           :integer          not null, primary key
#  company_id   :integer
#  office_type  :string(32)       not null
#  mls_id       :string(8)        not null
#  name         :string(255)      not null
#  phone        :string(14)
#  address_1    :string(255)
#  address_2    :string(255)
#  city         :string(255)
#  state        :string(2)
#  zipcode      :string(16)
#  email        :string(255)
#  office_logo  :string(255)
#  office_image :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

# CHARTER
#   Describe the office for which an agent (or inspector) works. Used for branding on the agent/listing pages.
#
# USAGE
#
# NOTES AND WARNINGS
#
class Office < ActiveRecord::Base
  include ApplicationHelper
  
  OFFICE_TYPE_LEN = 32

  REAL_ESTATE_OFFICE = 'Real Estate'
  HOME_INSPECTOR = 'Home Inspector'
  VALID_OFFICE_TYPES = [REAL_ESTATE_OFFICE, HOME_INSPECTOR]
  
  belongs_to :company
  has_many :agents, :dependent => :restrict_with_exception

  mount_uploader :office_logo, ImageUploader
  mount_uploader :office_image, ImageUploader
  
  validates :office_type, :inclusion => { :in => VALID_OFFICE_TYPES },
                          :length => { :maximum => OFFICE_TYPE_LEN }
  validates :mls_id, :presence => true, 
                     :length => { :maximum => MLS_ID_LEN }     
  validates_presence_of :name                         
  validates :state, :inclusion => { in: US_STATES }, :allow_blank => true
  validates :phone, :format => { with: US_PHONE_REGEX }, :allow_blank => true
  validates :zipcode, :format => { with: US_ZIP_REGEX }, :allow_blank => true
end
