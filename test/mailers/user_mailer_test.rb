require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'welcome_email' do
  	@user = users(:user1)
  	welcome = UserMailer.welcome_email(@user)
  	assert_equal "Welcome to OdinBook", 		 welcome.subject
  	assert_equal [@user.email], 				 welcome.to
  	assert_equal ['notifications@odinbook.com'], welcome.from
  	assert_match @user.name, 					 welcome.body.encoded
  end
end
