require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  def setup
  	@user = users(:user1)
  	@post = posts(:post2)
  end

  test 'redirect to sign in if not authenticated' do  
  	get :comments, id: @post
  	assert_redirected_to new_user_session_path
  end

  test 'redirect to home if not correct user' do
  	sign_in @user
  	get :edit, id: @post
  	assert_redirected_to root_path
  end
end
