class Relationship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friends, class_name: "User"

	validates_presence_of :user_id, :friend_id
end
