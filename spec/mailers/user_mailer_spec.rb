describe UserMailer do
  describe "Comment email" do
    CATEGORY = 'Comment'
    CONTENT = 'This is a comment'
    
    let(:msg) { UserMailer.comment_email(CATEGORY, CONTENT) }

    it "should return a message object" do
      expect(msg).to_not be_nil
    end
  
    it "should have the right sender" do
      expect(msg.from.to_s).to match(ApplicationHelper::MAILER_FROM_ADDRESS)
    end
    
    describe "Send the message" do
      before { msg.deliver }
        
      it "should get queued" do
        expect(ActionMailer::Base.deliveries).to_not be_empty
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
      # msg.to is a Mail::AddressContainer object, not a string
      # Even then, converting to a string gives you ["<address>"], so match captures the intent easier
      it "should be sent to administrators" do
        ApplicationHelper::SHOWINGS_ADMIN.each do |admin|
          expect(msg.to.to_s).to match(admin)
        end
      end
      
      it "should have the right subject" do
        expect(msg.subject).to match(CATEGORY)
      end
      
      it "should have the right content" do
        expect(msg.body.encoded).to match(CONTENT)
        
        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end
    end
  end
end
