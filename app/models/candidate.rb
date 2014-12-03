# == Schema Information
#
# Table name: candidates
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Candidate < ActiveRecord::Base
  include ApplicationHelper

  attr_accessible :email, :first_name, :last_name
  
  validates :email, :uniqueness => { :case_sensitive => false },
                    :format => { with: EMAIL_REGEX }
end
