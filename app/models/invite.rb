class Invite < ActiveRecord::Base
	belongs_to :user
	belongs_to :invites, class_name: "User"

	validates_presence_of :user, :invites
end
