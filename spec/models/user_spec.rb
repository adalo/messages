require 'spec_helper'

describe User do

  	describe "#send_message" do

	 	before(:each) do
			@jack = User.create!
	  		@jill = User.create!
	  	end

	  	context "when the user is under their subscription limit" do

	  		before(:each) do
				@jack.subscription = Subscription.new
				@jack.subscription.stub(:can_send_message?).and_return true
			end

		  	it "sends a message from the current user to another user" do
		  		msg = @jack.send_message(title: "the title", text: "the text", recipient: @jill)
		  		@jill.received_messages.should == [msg]
		  	end

		  	it "creates a new message with the submitted attributes" do
		  		msg = @jack.send_message(title: "the title", text: "the text", recipient: @jill)
		  		expect(msg.title).to eq "the title"
		  		expect(msg.text).to eq "the text"
		  	end

		  	it "adds the message to the sender's sent messages" do
		  		msg = @jack.send_message(title: "the title", text: "the text", recipient: @jill)
		  		@jack.sent_messages.should == [msg]
		  	end		  				  		
 		end

 		context "when the user is over their subscription limit" do
 			before(:each) do
 				@jack.subscription = Subscription.new
 				@jack.subscription.stub(:can_send_message?).and_return false
 			end

 			it "does not create a message" do
 				expect(lambda {
 					@jack.send_message(title: "the title", text: "the text", recipient: @jill)
 					}).not_to change(Message, :count)
 			end
 		end
	end
end
