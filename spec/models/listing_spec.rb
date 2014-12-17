# == Schema Information
#
# Table name: listings
#
#  id         :integer          not null, primary key
#  agent_id   :integer
#  mls_num    :integer          not null
#  address_1  :string(255)
#  address_2  :string(255)
#  city       :string(255)
#  state      :string(2)
#  zipcode    :string(10)
#  created_at :datetime
#  updated_at :datetime
#

RSpec.describe Listing, :type => :model do
  let(:agent) { FactoryGirl.create(:agent) }
  let(:listing) { FactoryGirl.create(:listing, :agent => agent) }
  
  subject { listing }
  
  it "should respond to everything" do
    expect(listing).to respond_to(:mls_num)
    expect(listing).to respond_to(:address_1)
    expect(listing).to respond_to(:address_2)
    expect(listing).to respond_to(:city)
    expect(listing).to respond_to(:state)
    expect(listing).to respond_to(:zipcode)
  end
  
  its(:agent) { should be == agent }
  
  it { should be_valid }
  
  describe "missing mls" do
    before { listing.mls_num = ' ' }
    
    it { should_not be_valid }
  end
  
  describe "invalid mls" do
    [-20, 20.5, 'abc'].each do |num|
      before { listing.mls_num = num }
      
      it { should_not be_valid }
    end
  end
  
  describe "state" do 
    describe "validate against list" do
      ApplicationHelper::US_STATES.each do |state|
        before { listing.state = state }
        
        it { should be_valid }
      end
      
      describe "invalid state" do
        before { listing.state = "Not a state" }
        
        it { should_not be_valid }
      end
    end
  end

  describe "zip code (valid)" do
    ["13416", "15237", "15237"].each do |code|
      before { listing.zipcode = code }
      
      it { should be_valid }
    end
  end

  describe "zip code (invalid)" do  
    ["xyz", "1343", "1343k", "134163423", "13432-", "13432-232", "13432-232x", "34234-32432", "32432_3423"].each do |code|
      before { listing.zipcode = code }
     
      it { should_not be_valid }
    end
  end   
  
  describe "contents" do
    let(:listing) { FactoryGirl.create(:listing_with_contents) }
    
    it "should have contents" do
      expect(listing.contents.count).to eq(3)
    end
    
    describe "Delete" do
      before { listing.destroy }
      
      it "should be gone" do
        expect(Content.count).to eq(0)
      end
    end
  end 
end
