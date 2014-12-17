# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  type                   :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  agent_code             :integer
#  office_phone           :string(255)
#  cell_phone             :string(255)
#  image                  :string(255)
#  office_id              :integer
#

describe User do
  let(:user) { FactoryGirl.create(:user) }
  
  subject { user }
  
  it "should respond to everything" do
    expect(user).to respond_to(:email)
    expect(user).to respond_to(:password)
    expect(user).to respond_to(:password_confirmation)
  end

  it { should be_valid }
    
  describe "missing/invalid email" do
    before { user.email = " " }
    
    it { should_not be_valid }
    
    describe "email format (valid)" do
      ApplicationHelper::VALID_EMAILS.each do |address|
        before { user.email = address }
        
        it { should be_valid }
      end
    end

    describe "email format (invalid)" do
      ApplicationHelper::INVALID_EMAILS.each do |address|
        before { user.email = address }
        
        it { should_not be_valid }
      end
    end
  end
  
  describe "Agent" do
    let(:office) { FactoryGirl.create(:office) }
    let(:agent) { FactoryGirl.create(:agent, :office => office) }
    
    subject { agent }
    
    it "should respond to everything" do
      expect(agent).to respond_to(:agent_code)
      expect(agent).to respond_to(:office_phone)
      expect(agent).to respond_to(:cell_phone)
    end
    
    its(:office) { should be == office }
    it { should be_valid }
    
    describe "Missing agent code" do
      before { agent.agent_code = ' ' }
      
      it { should_not be_valid }
    end
    
    describe "office phone (valid)" do
      ["(412) 441-4378", "(724) 342-3423", "(605) 342-3242"].each do |phone|
        before { agent.office_phone = phone }
        
        it { should be_valid }
      end
    end
  
    # Should actually introduce phone normalization if we want people to type them in
    # Many of these should be valid after normalization 
    describe "office phone (invalid)" do  
      ["xyz", "412-441-4378", "441-4378", "1-800-342-3423", "(412) 343-34232", "(412) 343-342x"].each do |phone|
        before { agent.office_phone = phone }
       
        it { should_not be_valid }
      end
    end   

    describe "call phone (valid)" do
      ["(412) 441-4378", "(724) 342-3423", "(605) 342-3242"].each do |phone|
        before { agent.cell_phone = phone }
        
        it { should be_valid }
      end
    end
  
    # Should actually introduce phone normalization if we want people to type them in
    # Many of these should be valid after normalization 
    describe "cell phone (invalid)" do  
      ["xyz", "412-441-4378", "441-4378", "1-800-342-3423", "(412) 343-34232", "(412) 343-342x"].each do |phone|
        before { agent.cell_phone = phone }
       
        it { should_not be_valid }
      end
    end   
  end
  
  describe "profile" do
    let(:agent) { FactoryGirl.create(:agent_with_profile) }
    
    it "should have a profile" do
      expect(agent.profile).to_not be_nil
      expect(agent.profile.agent).to eq(agent)
    end
  end
  
  describe "Listings" do
    let(:agent) { FactoryGirl.create(:agent_with_listings) }
    
    it "should have listings" do
      expect(agent.listings.count).to eq(2)
    end
    
    describe "destroy" do
      before { agent.destroy }
      
      it "should be gone" do
        expect(Content.count).to eq(0)
      end
    end
  end
end
