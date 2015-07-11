class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :post

	validates :content, presence: true
	validates_presence_of :user
	validates_presence_of :post
end
