require 'spec_helper'

describe MessagesController do
	describe "POST create" do
		let(:message) { mock_model(Message).as_null_object }
		let(:expected_strong_params) { ActionController::Parameters.new("text" => "a quick brown fox") }
		before do
			Message.stub(:new).and_return(message)
		end

		it "creates a new message" do
			Message.should_receive(:new).with(expected_strong_params).and_return(message)
			post :create, message: { text: "a quick brown fox" }
		end

		# these contexts are all explicitly sending :message on :create because I've had to 
		# add params.require(:message) in order to make this example Rails 4/Ruby 2 friendly.
		# I feel like it shouldn't be required in send the :message every time, but haven't
		# figured out how to permit :text without requiring :message

		
		context "when the message saves successfully", :to_refactor => true do
			before do
				message.stub(:save).and_return(true)
			end

			it "sets a flash[:notice] message" do
				post :create, message: { text: "a quick brown fox" }			
				flash[:notice].should eq("The message was saved successfully.")
			end
	
			it "redirects to the Messages index" do
				post :create, message: { text: "a quick brown fox" }
				response.should redirect_to(action: "index")
			end
		end

		
		context "when the message save fails", :to_refactor => true do
			before do
				message.stub(:save).and_return(false)
			end

			it "assigns @message" do
				post :create, message: { text: "a quick brown fox" }
				assigns[:message].should eq(message)
			end
			it "renders the new template" do
				post :create, message: { text: "a quick brown fox" }
				response.should render_template("new")
			end

		end
	end
end
