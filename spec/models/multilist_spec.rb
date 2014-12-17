# == Schema Information
#
# Table name: multilists
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  state      :string(2)        not null
#  created_at :datetime
#  updated_at :datetime
#

RSpec.describe Multilist, :type => :model do
  let(:mls) { FactoryGirl.create(:multilist) }
  
  subject { mls }
  
  it "should respond to everything" do
    expect(mls).to respond_to(:name)
    expect(mls).to respond_to(:state)
  end
  
  it { should be_valid }
  
  describe "Missing name" do
    before { mls.name = ' ' }
    
    it { should_not be_valid }
  end
  
  describe "state" do 
    describe "validate against list" do
      ApplicationHelper::US_STATES.each do |state|
        before { mls.state = state }
        
        it { should be_valid }
      end
      
      describe "invalid state" do
        before { mls.state = "Not a state" }
        
        it { should_not be_valid }
      end
    end
  end
  
  describe "Realtors" do
    let(:mls) { FactoryGirl.create(:mls_with_realtors) }
    
    it "should have realtors" do
      expect(mls.realtors.count).to eq(10)
    end
    
    describe "no dups" do
      before { @r = mls.realtors.first.dup }
      
      it "should not allow them" do
        expect { @r.save! }.to raise_exception(ActiveRecord::RecordInvalid)
      end
    end
    
    describe "delete" do
      before { mls.destroy }
      
      it "should be gone" do
        expect(Realtor.count).to eq(0)
      end
    end
  end
end
