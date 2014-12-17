# == Schema Information
#
# Table name: candidates
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

# CHARTER
#   Store emails on teaser page for lead capture
#
# USAGE
#
# NOTES AND WARNINGS
#
class Candidate < ActiveRecord::Base
  include ApplicationHelper

  validates :email, :uniqueness => { :case_sensitive => false },
                    :format => { with: EMAIL_REGEX }
end
