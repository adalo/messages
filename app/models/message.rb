class Message < ActiveRecord::Base
	belongs_to :recipient, class_name: "User"
	validates :title, :text, :recipient, presence: true
end
