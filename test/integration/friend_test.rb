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
    get friends_user_path(@user)
    assert_not @user.friends.empty?
    assert_match @user.friends.count.to_s, response.body
    @user.friends.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "should friend via post" do
    assert_difference '@user.friends.count', 1 do
      post relationships_path, @other
    end
  end


  test "should unfriend via delete" do
    @user.friend(@other)
    relationship = @user.friends.find_by(user_id: @other.id)
    assert_difference '@user.friends.count', -1 do
      delete relationship_path(relationship)
    end
  end

end