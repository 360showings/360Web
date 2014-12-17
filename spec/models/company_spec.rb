# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string(80)       not null
#  created_at :datetime
#  updated_at :datetime
#

RSpec.describe Company, :type => :model do
  let(:company) { FactoryGirl.create(:company) }
  
  subject { company }
  
  it "should respond to everything" do
    expect(company).to respond_to(:name)
  end
  
  it { should be_valid }
  
  describe "Missing name" do
    before { company.name = ' ' }
    
    it { should_not be_valid }
  end
  
  describe "offices" do
    let(:company) { FactoryGirl.create(:company_with_offices) }
        
    it "should have offices" do
      expect(company.offices.count).to eq(3)
    end
    
    describe "delete" do
      before { company.destroy }
      
      it "should be gone" do
        expect(Office.count).to eq(0)
      end
    end
  end
end
