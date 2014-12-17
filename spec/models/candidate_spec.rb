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

describe Candidate do
  let(:candidate) { FactoryGirl.create(:candidate) }
  
  subject { candidate }
  
  it "should respond do everything" do
    expect(candidate).to respond_to(:first_name)
    expect(candidate).to respond_to(:last_name)
    expect(candidate).to respond_to(:email)
  end
  
  it { should be_valid }
  
  describe "missing/invalid email" do
    before { candidate.email = " " }
    
    it { should_not be_valid }
    
    describe "email format (valid)" do
      ApplicationHelper::VALID_EMAILS.each do |address|
        before { candidate.email = address }
        
        it { should be_valid }
      end
    end

    describe "email format (invalid)" do
      ApplicationHelper::INVALID_EMAILS.each do |address|
        before { candidate.email = address }
        
        it { should_not be_valid }
      end
    end
  end
end
