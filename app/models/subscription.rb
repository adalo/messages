class Subscription < ActiveRecord::Base
	has_one :user

	def can_send_messages?
		user = self.user
		user.sent_messages.count <= self.subscription_limit
	end
end
