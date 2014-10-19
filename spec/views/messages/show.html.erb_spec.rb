require 'spec_helper'

describe "messages/show.html.erb" do
	it "displays the text attribute of the message" do
		assign(:message, double("Message", text: "Hello world!"))
		render
		expect(rendered).to match /Hello world!/
	end
end