require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user_one = users(:user1)
		@user_two = users(:user2)
	end

	test 'not invited' do
		assert_not @user_one.invited?(@user_two)
	end
end
