require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  test "should follow and unfollow a user" do
    test1  = users(:test1)
    test2   = users(:test2)
    assert_not test1.friends?(test2)
    test1.friend(test2)
    assert test1.friends?(test2)
    assert test2.friends.include?(test1)
    test1.unfriend(test2)
    assert_not test1.friends?(test2)
  end
end
