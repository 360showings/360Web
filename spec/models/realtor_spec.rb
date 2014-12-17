# == Schema Information
#
# Table name: realtors
#
#  id           :integer          not null, primary key
#  multilist_id :integer
#  first_name   :string(255)      not null
#  last_name    :string(255)      not null
#  agent_code   :string(255)
#  office_code  :string(8)
#  email        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

RSpec.describe Realtor, :type => :model do
  let(:mls) { FactoryGirl.create(:multilist) }
  let(:realtor) { FactoryGirl.create(:realtor, :multilist => mls) }
  
  subject { realtor }
  
  it "should respond to everything" do
    expect(realtor).to respond_to(:first_name)
    expect(realtor).to respond_to(:last_name)
    expect(realtor).to respond_to(:agent_code)
    expect(realtor).to respond_to(:office_code)
    expect(realtor).to respond_to(:email)
  end
  
  its(:multilist) { should be == mls }
  
  it { should be_valid }
  
  describe "missing first name" do
    before { realtor.first_name = ' ' }
    
    it { should_not be_valid }
  end

  describe "missing last name" do
    before { realtor.last_name = ' ' }
    
    it { should_not be_valid }
  end
  
  describe "invalid first name" do
    describe "email format (valid)" do
      ApplicationHelper::VALID_EMAILS.each do |address|
        before { realtor.email = address }
        
        it { should be_valid }
      end
    end

    describe "email format (invalid)" do
      ApplicationHelper::INVALID_EMAILS.each do |address|
        before { realtor.email = address }
        
        it { should_not be_valid }
      end
    end
  end
  
  describe "office code" do
    before { realtor.office_code = '1'*(ApplicationHelper::MLS_ID_LEN + 1) }
    
    it { should_not be_valid }
  end
end
