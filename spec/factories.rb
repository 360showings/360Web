FactoryGirl.define do
  sequence(:random_first_name) { |n| Faker::Name.first_name }
  sequence(:random_last_name) { |n| Faker::Name.last_name }
  sequence(:random_name) { |n| Faker::Name.name }
  sequence(:random_email) { |n| Faker::Internet.email }
  sequence(:random_phrase) { |n| Faker::Company.catch_phrase }
  sequence(:random_paragraphs) { |n| Faker::Lorem.paragraphs.join("\n") }
  sequence(:random_url) { |n| "http://www." + Faker::Internet.domain_name }
  sequence(:random_facebook) { |n| "www.facebook.com/CoolDude_#{n}" }
  sequence(:random_company_name) { |n| Faker::Company.name }
  sequence(:random_phone) { |n| Faker::PhoneNumber.phone_number }
  sequence(:sequential_phone) { |n| '(412) 400-' + sprintf("%04d", n) }
  sequence(:random_street) { |n| Faker::Address.street_address }
  sequence(:random_suite) { |n| Faker::Address.secondary_address }
  sequence(:random_city) { |n| Faker::Address.city }
  sequence(:random_zip) { |n| Faker::Address.zip_code }
  sequence(:random_license) { |n| "RS#{Random.rand(200000) + 100000}" }
  sequence(:random_state) do
    st = ""
    until ApplicationHelper::US_STATES.member?(st)
      st = Faker::Address.state_abbr
    end
    st
  end
  
  factory :user do 
    email { generate(:random_email) }
    password "Password"
    password_confirmation "Password"    
  end
  
  factory :agent do
    office
    
    email { generate(:random_email) }
    password "Password"
    password_confirmation "Password"    
    agent_code { Random.rand(100000) + 100000 }
    office_phone { generate(:sequential_phone) }
    cell_phone { generate(:sequential_phone) }
    
    factory :agent_with_profile do
      after(:create) do |agent|
        FactoryGirl.create(:profile, :agent => agent)
      end
    end
    
    factory :agent_with_listings do
      transient do
        num_listings 2
      end
      
      after(:create) do |agent, evaluator|
        FactoryGirl.create_list(:listing, evaluator.num_listings, :agent => agent)
      end  
    end
  end
  
  factory :profile do
    agent
    
    bio { generate(:random_paragraphs) }
    website { generate(:random_url) }
    facebook { generate(:random_facebook) }
    designations { generate(:random_name) }
    license { generate(:random_license) }
  end
  
  factory :multilist do
    name { generate(:random_company_name) }
    state { generate(:random_state) }   
    
    factory :mls_with_realtors do
      transient do
        num_realtors 10
      end
      
      after(:create) do |multilist, evaluator|
        FactoryGirl.create_list(:realtor, evaluator.num_realtors, :multilist => multilist)
      end
    end 
  end
  
  factory :realtor do
    multilist
    
    email { generate(:random_email) }
    first_name { generate(:random_first_name) }
    last_name { generate(:random_last_name) }
    office_code { Random.rand(10000) + 10000 }
    agent_code { Random.rand(100000) + 100000 }
  end
  
  factory :candidate do
    email { generate(:random_email) }
    first_name { generate(:random_first_name) }
    last_name { generate(:random_last_name) }
  end
  
  factory :company do
    name { generate(:random_company_name) }
    
    factory :company_with_offices do
      transient do
        num_offices 3
      end
      
      after(:create) do |company, evaluator|
        FactoryGirl.create_list(:office, evaluator.num_offices, :company => company)
      end
    end
  end
  
  factory :office do
    company
    
    office_type { Office::VALID_OFFICE_TYPES.sample }
    mls_id { Random.rand(10000) + 10000 }
    name { generate(:random_company_name) }
    phone { generate(:sequential_phone) }
    address_1 { generate(:random_street) }
    address_2 { generate(:random_suite) }
    city { generate(:random_city) }
    state { generate(:random_state) }
    zipcode { generate(:random_zip) }
    email { generate(:random_email) }
  end
  
  factory :listing do
    agent
    
    mls_num { Random.rand(100000) + 1000000 }
    address_1 { generate(:random_street) }
    address_2 { generate(:random_suite) }
    city { generate(:random_city) }
    state { generate(:random_state) }
    zipcode { generate(:random_zip) }
    
    factory :listing_with_contents do
      transient do
        num_contents 3
      end
      
      after(:create) do |listing, evaluator|
        FactoryGirl.create_list(:content, evaluator.num_contents, :listing => listing)
      end
    end
  end
  
  factory :content do
    listing
    
    content_type { Content::VALID_CONTENT_TYPES.sample }
    content_link { generate(:random_url) }
    caption { generate(:random_phrase) }
    content_group { Random.rand(10) + 1 }
  end  
end
