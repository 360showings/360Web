# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
require 'phone_utils'

first = true
Company.destroy_all
Office.destroy_all

CSV.foreach('FinalOffices.csv', encoding: 'windows-1251:utf-8') do |row|    
  if first
    first = false
    next
  end
    
  o = Office.create!(:mls_id => row[0].strip, :office_type => row[1].strip, :name => row[3].strip, :phone => PhoneUtils::normalize_phone(row[4].strip), 
                     :address_1 => row[5].strip, :city => row[7].strip, :state => row[8].strip.upcase, :zipcode => row[9].strip) 
  unless row[6].blank?
    o.update_attribute(:address_2, row[6].strip)
  end   
  
  unless row[10].blank?
    o.update_attribute(:email, row[10].strip)
  end
  
  unless row[2].blank?
    o.company_id = Company.find_or_create_by(:name => row[2].strip).id
    o.save!
  end
end

Multilist.destroy_all

mls = Multilist.create!(:name => 'West Penn', :state => 'PA')

CSV.foreach('FinalAgents.csv', encoding: 'windows-1251:utf-8') do |row|    
  r = mls.realtors.create!(:first_name => row[0].strip, :last_name => row[1].strip, :agent_code => row[2].strip, :office_code => row[3].strip)
  email = row[4].strip
  unless ('email' == email.downcase) or ('-' == email) or email.blank?
    r.update_attribute(:email, email)
  end
end
