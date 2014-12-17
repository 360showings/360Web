# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  type                   :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  agent_code             :integer
#  office_phone           :string(255)
#  cell_phone             :string(255)
#  image                  :string(255)
#  office_id              :integer
#

# CHARTER
#   The base class user is a non-agent (admin). Agent users use the Agent subclass, and are connected to Offices, Profiles, etc.
#
# USAGE
#
# NOTES AND WARNINGS
#
class User < ActiveRecord::Base
  include ApplicationHelper
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Note that devise has a unique index on email (case sensitive?)
  validates :email, :presence => true,
                    :uniqueness => { case_sensitive: false },
                    :format => { with: EMAIL_REGEX }
end

class Agent < User
  mount_uploader :image, ImageUploader

  belongs_to :office
  has_one :profile
  has_many :listings, :dependent => :destroy
  
  validates_presence_of :agent_code
  validates :office_phone, :format => { with: US_PHONE_REGEX }
  validates :cell_phone, :format => { with: US_PHONE_REGEX }
end
