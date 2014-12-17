# == Schema Information
#
# Table name: profiles
#
#  id           :integer          not null, primary key
#  agent_id     :integer
#  bio          :text
#  website      :string(255)
#  facebook     :string(255)
#  license      :string(255)
#  designations :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

RSpec.describe Profile, :type => :model do
  let(:agent) { FactoryGirl.create(:agent) }
  let(:profile) { FactoryGirl.create(:profile, :agent => agent) }
  
  subject { profile }
  
  it "should respond to everything" do
    expect(profile).to respond_to(:bio)
    expect(profile).to respond_to(:website)
    expect(profile).to respond_to(:facebook)
    expect(profile).to respond_to(:license)
    expect(profile).to respond_to(:designations)
  end
  
  its(:agent) { should be == agent }
  it { should be_valid }
  
  describe "Invalid website" do 
    before { profile.website = 'not a web site' }
    
    it { should_not be_valid }
  end
  
  describe "Missing website" do
    before { profile.website = nil }
    
    it { should be_valid}
  end

  describe "Invalid facebook" do 
    before { profile.facebook = FactoryGirl.generate(:random_url) }
    
    it { should_not be_valid }
  end
  
  describe "Missing facebook" do
    before { profile.facebook = nil }
    
    it { should be_valid}
  end
end
