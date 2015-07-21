require 'test_helper'

class PostTest < ActiveSupport::TestCase
	def setup
		@post = Post.new(content: "Quack", user_id: 1)
		@post2 = posts(:post1)
		@user = users(:user1)
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

	test 'is not liked' do
		assert_not @post.liked?
	end

	test 'post is liked' do
		assert_difference 'Like.count', 1 do
	  	  	@like = @post2.likes.create!(user_id: @user.id)
		end
		assert @post2.liked?
	end

end
