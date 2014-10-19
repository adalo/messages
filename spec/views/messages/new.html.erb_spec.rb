require 'spec_helper'

describe "messages/new.html.erb" do
	let(:message) do
		mock_model("Message").as_new_record.as_null_object
	end

	before do
		assign(:message, message)
	end

	it "renders a form to create a message" do
		render
		rendered.should have_selector('form[method=post]')
		Capybara.string(rendered).find('form').should have_selector('input[type=submit][value="Save"]')
	end

	it "renders a text field for the message" do
		message.stub(title: "the title")
		render
		Capybara.string(rendered).find('form').should have_selector('input[type="text"][name="message[title]"][value="the title"]')
	end

	it "renders a text area for the message text" do
		message.stub(text: "the message")
		render
		# this should also check for something like [name="message[text]"][content="the message"] but not sure exact format until further implemented
		Capybara.string(rendered).find('form').should have_selector('textarea')

	end

end