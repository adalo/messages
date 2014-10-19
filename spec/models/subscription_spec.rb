require 'spec_helper'

describe Subscription do

	before(:each) do
	  	@subscription = Subscription.new(subscription_limit: 2)
		@jack = mock_model(User)
		@jack.stub(:sent_messages)
		allow_message_expectations_on_nil
	end
	
	describe "#can_send_messages?" do

  	context "when a user has not reached the subscription limit for the month" do
  		it "returns true" do
  			@jack.sent_messages.stub(:count).and_return 1
  			@subscription.stub(:user).and_return @jack
  			expect(@subscription.can_send_messages?).to eq true
  		end

  	end

  	context "when a user has reached the subscription limit for the month" do
  		it "returns false" do
  			@jack.sent_messages.stub(:count).and_return 3
  			@subscription.stub(:user).and_return @jack
  			expect(@subscription.can_send_messages?).to eq false
  		end
  	end
  end
end
