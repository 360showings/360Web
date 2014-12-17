# == Schema Information
#
# Table name: multilists
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  state      :string(2)        not null
#  created_at :datetime
#  updated_at :datetime
#

class Multilist < ActiveRecord::Base
  include ApplicationHelper
  
  has_many :realtors, :dependent => :destroy
  
  validates_presence_of :name
  validates :state, :inclusion => { in: US_STATES }, :allow_blank => true
end
