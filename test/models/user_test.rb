require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user_one = users(:user1)
		@user_two = users(:user2)
	end

	test 'not invited' do
		assert_not @user_one.invited?(@user_two)
	end

	test 'invited' do
		@user_one.invite(@user_two)
		assert @user_one.invited?(@user_two)
	end

	test 'reject invite' do
		@user_one.invite(@user_two)
		assert_difference 'Invite.count', -1 do
			@user_two.reject(@user_one)
		end
		assert_not @user_one.invited?(@user_two)
	end

	test 'not friends' do
		@user_one.friends?(@user_two)
	end

	test 'friends' do
		assert_difference 'Relationship.count', 2 do
			@user_one.friend(@user_two)
		end
		assert @user_one.friends?(@user_two)
		assert @user_two.friends?(@user_one)
	end

	test 'can unfriend' do
		assert_difference 'Relationship.count', 2 do
			@user_one.friend(@user_two)
		end
		assert @user_one.friends?(@user_two)
		assert @user_two.friends?(@user_one)

		assert_difference 'Relationship.count', -2 do
			@user_one.unfriend(@user_two)
		end
		assert_not @user_one.friends?(@user_two)
		assert_not @user_two.friends?(@user_one)
	end

end
