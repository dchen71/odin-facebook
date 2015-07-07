class Invite < ActiveRecord::Base
	belongs_to :user
	belongs_to :invites, class_name: "User"

	validates_presence_of :user_id, :invite_id
end
