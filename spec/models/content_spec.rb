# == Schema Information
#
# Table name: contents
#
#  id            :integer          not null, primary key
#  listing_id    :integer
#  content_type  :string(255)
#  content_link  :string(255)
#  caption       :string(255)
#  content_group :integer
#  created_at    :datetime
#  updated_at    :datetime
#

RSpec.describe Content, :type => :model do
  let(:listing) { FactoryGirl.create(:listing) }
  let(:content) { FactoryGirl.create(:content, :listing => listing) }
  
  subject { content }
  
  it "should respond to everything" do
    expect(content).to respond_to(:content_type)
    expect(content).to respond_to(:content_link)
    expect(content).to respond_to(:caption)
    expect(content).to respond_to(:content_group)
  end
  
  its(:listing) { should be == listing }
  it { should be_valid }
  
  describe "content types" do
    Content::VALID_CONTENT_TYPES.each do |type|
      before { content.content_type = type }
      
      it { should be_valid }
    end
  end
  
  describe "invalid content types" do
    [nil, 'Invalid'].each do |type|
      before { content.content_type = type }
      
      it { should_not be_valid }
    end
  end
  
  describe "Missing content group" do
    before { content.content_group = nil }
    
    it { should be_valid }
  end
  
  describe "Invalid content group" do
    [-5, 2.5, 'abc'].each do |group|
     before { content.content_group = group }
     
     it { should_not be_valid } 
    end
  end
end
