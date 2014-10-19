require 'spec_helper'

describe Message do
	before(:each) do
		@message = Message.new(title: "the title", text: "the text", recipient: mock_model("User"))
	end
  it "is valid with valid attributes" do
  	expect(@message).to be_valid  	
  end

  it "is not valid without a title" do
  	@message.title = nil
  	expect(@message).not_to be_valid
  end

  it "is not valid without text" do
	@message.text = nil
  	expect(@message).not_to be_valid
  end

  it "is not valid without a recipient" do
  	@message.recipient = nil
  	expect(@message).not_to be_valid
  end
end
