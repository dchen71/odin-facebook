require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @friend = Relationship.new(user_id: 1, friend_id: 2)
  end

  test 'should be valid' do
    assert @friend.valid?
  end

  test 'user_id should be present' do
    @friend.user_id = " "
    assert_not @friend.valid?
  end

  test 'friend_id should be present' do
    @friend.friend_id = " "
    assert_not @friend.valid?
  end

  test "should friend and unfriend a user" do
    test1  = users(:user1)
    test2   = users(:user2)
    assert_not test1.friends?(test2)
    test1.friend(test2)
    assert test1.friends?(test2)
    assert test2.friends?(test1)
    test1.unfriend(test2)
    assert_not test1.friends?(test2)
  end
end
