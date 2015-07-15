require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
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
