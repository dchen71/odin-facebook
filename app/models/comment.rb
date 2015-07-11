class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	validates :content, presence: true
	validates_presence_of :user_id
	validates_presence_of :post_id
end
