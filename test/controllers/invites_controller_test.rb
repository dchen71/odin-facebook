require 'test_helper'


class InvitesControllerTest < ActionController::TestCase
  def setup
  	@user = users(:user1)
  	@other = users(:user2)
  	@invite = invites(:invite1)
  end

  test 'redirect from create to sign in when not logged in' do
  	post :create, id: @invite, invite: {user_id: @user.id, invite_id: @other.id}
  	assert_redirected_to new_user_session_path
  end

  test 'redirect from delete to sign in when not logged in' do
  	delete :destroy, id: @invite
  	assert_redirected_to new_user_session_path
  end
end
