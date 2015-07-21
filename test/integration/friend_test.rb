require 'test_helper'

class FriendTest < ActionDispatch::IntegrationTest

  def setup
    @user  = users(:user5)
    @other = users(:user6)
    log_in_as(@user)
  end

  test 'user one with no friends' do
    assert_not @user.friends.any?
  end

  test 'user one with a friend' do
    @user.friend(@other)
    assert @user.friends.include?(@other)
  end

  test "friend page" do
    @user.friend(@other)
    get friends_user_path(@user)
    assert_not @user.friends.empty?
    assert_match @user.friends.count.to_s, response.body
    @user.friends.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "should friend via post" do
    @other.invite(@user)
    assert_difference '@user.friends.count', 1 do
      post relationships_path, id: Invite.last
    end
  end


  test "should unfriend via delete" do
    @user.friend(@other)
    assert_difference '@user.friends.count', -1 do
      delete relationship_path(id: Relationship.last.id)
    end
  end

end