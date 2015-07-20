require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
  	@user = users(:user1)
  	@other = users(:user2)
  end

  test 'should redirect when not logged in' do
  	get :index
  	assert_redirected_to new_user_session_path
  end

  test 'should redirect when wrong user for invites' do
  	sign_in @other
  	get :invites, id: @user
  	assert_redirected_to root_path
  end
end
