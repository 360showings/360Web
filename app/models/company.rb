# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(80)       not null
#  created_at :datetime
#  updated_at :datetime
#

# CHARTER
#   Provide a top-level category for common offices, for ease of data entry
#
# USAGE
#   There are hundreds of offices and home inspectors with lockbox access. There are even government agencies (not worried about them).
# The large companies like Hanna have office names like HANNA LOCATION, which we'd like to group together so data entry is easier.
# Offices with no parent company are either independent, or the office name is the company name (office names are not unique, just ids are).

# NOTES AND WARNINGS
#
class Company < ActiveRecord::Base
  has_many :offices, :dependent => :destroy
  
  validates_presence_of :name
end
