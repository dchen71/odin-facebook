class Relationship < ActiveRecord::Base
	belongs_to :invites, class_name: "User"
	belongs_to :friends, class_name: "User"
end
