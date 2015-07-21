require 'test_helper'

class InviteTest < ActiveSupport::TestCase
  def setup
  	@invite = Invite.new(invite_id: 1, user_id: 1)
  end

  test 'is valid' do
  	assert @invite.valid?
  end

  test 'validates presence of user id' do
  	@invite.user_id = " "
  	assert_not @invite.valid?
  end

  test 'validates presence of invite id' do
  	@invite.invite_id = " "
  	assert_not @invite.valid?
  end
end
