require 'test_helper'

class PostTest < ActiveSupport::TestCase
	def setup
		@post = Post.new(content: "Quack", user_id: 1)
	end

	test '@post is valid' do
		assert @post.valid?
	end

	test 'content cannot be blank' do
		@post.content = " "
		assert_not @post.valid?
	end

	test 'user_id cannot be blank' do
		@post.user_id = " "
		assert_not @post.valid?
	end

	#test 'dependent comments will be destroyed' do
	#	@post = posts(:post1)
	#	@comment = comments(:com2)
	#	assert_difference ('Comment.count'), -1 do
	#		@post.destroy
	#		@comment.reload
	#	end
	#end
end
