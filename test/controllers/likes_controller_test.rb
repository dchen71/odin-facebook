require 'test_helper'

class LikesControllerTest < ActionController::TestCase
  def setup
  	@user = users(:user2)
  	@like = likes(:like1)
  end

  test 'redirect if incorrect user on destroy' do
  	sign_in @user
  	delete :destroy, id: @like
  	assert_redirected_to root_path
  end


end
