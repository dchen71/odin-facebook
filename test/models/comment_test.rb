require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
  	@comment = Comment.new(user_id: 10, content: "Quack", post_id: 10)
  	@comment2 = comments(:com1)
  	@user = users(:user1)
  end

  test 'comment requires presence of content' do
  	@comment.content = " "
  	assert_not @comment.valid?
  end

  test 'comment requires presence of user' do
  	@comment.user_id = " "
  	assert_not @comment.valid?
  end

  test 'comment requires presence of post id' do
  	@comment.post_id = " "
  	assert_not @comment.valid?
  end

  test 'comment is not liked' do
  	assert_not @comment.liked?
  end

  test 'comment is liked' do
  	assert_difference 'Like.count', 1 do
    	  	@like = @comment2.likes.create!(user_id: @user.id)
  	end
  	assert @com2.liked?
  end
end
