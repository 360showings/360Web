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

RSpec.describe Office, :type => :model do
  let(:company) { FactoryGirl.create(:company) }
  let(:office) { FactoryGirl.create(:office, :company => company) }
  
  subject { office }
  
  it "should respond to everything" do
    expect(office).to respond_to(:office_type)
    expect(office).to respond_to(:mls_id)
    expect(office).to respond_to(:name)
    expect(office).to respond_to(:phone)
    expect(office).to respond_to(:address_1)
    expect(office).to respond_to(:address_2)
    expect(office).to respond_to(:city)
    expect(office).to respond_to(:state)
    expect(office).to respond_to(:zipcode)
    expect(office).to respond_to(:email)
    expect(office).to respond_to(:office_logo)
    expect(office).to respond_to(:office_image)
  end
  
  it { should be_valid }
  
  its(:company) { should be == company }

  describe "type too long" do
    before { office.office_type = 't'*(Office::OFFICE_TYPE_LEN + 1) }
    
    it { should_not be_valid }
  end
  
  describe "valid type" do
    Office::VALID_OFFICE_TYPES.each do |ot|
      before { office.office_type = ot }
      
      it { should be_valid }
    end
  end
  
  describe "invalid type" do
    before { office.office_type = 'Fish' }
    
    it { should_not be_valid }
  end
  
  describe "mls missing" do
    before { office.mls_id = ' ' }
    
    it { should_not be_valid }
  end
  
  describe "invalid mls" do
    before { office.mls_id = 'm'*(ApplicationHelper::MLS_ID_LEN + 1) }
    
    it { should_not be_valid }
  end
  
  describe "missing name" do
    before { office.name = ' ' }
    
    it { should_not be_valid } 
  end
  
  describe "state" do 
    describe "validate against list" do
      ApplicationHelper::US_STATES.each do |state|
        before { office.state = state }
        
        it { should be_valid }
      end
      
      describe "invalid state" do
        before { office.state = "Not a state" }
        
        it { should_not be_valid }
      end
    end
  end

  describe "zip code (valid)" do
    ["13416", "15237", "15237"].each do |code|
      before { office.zipcode = code }
      
      it { should be_valid }
    end
  end

  describe "zip code (invalid)" do  
    ["xyz", "1343", "1343k", "134163423", "13432-", "13432-232", "13432-232x", "34234-32432", "32432_3423"].each do |code|
      before { office.zipcode = code }
     
      it { should_not be_valid }
    end
  end  

  describe "phone (valid)" do
    ["(412) 441-4378", "(724) 342-3423", "(605) 342-3242"].each do |phone|
      before { office.phone = phone }
      
      it { should be_valid }
    end
  end

  # Should actually introduce phone normalization if we want people to type them in
  # Many of these should be valid after normalization 
  describe "phone (invalid)" do  
    ["xyz", "412-441-4378", "441-4378", "1-800-342-3423", "(412) 343-34232", "(412) 343-342x"].each do |phone|
      before { office.phone = phone }
     
      it { should_not be_valid }
    end
  end   
end
