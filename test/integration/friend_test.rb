require 'test_helper'

class FriendTest < ActionDispatch::IntegrationTest

  def setup
    @user  = users(:user1)
    @other = users(:user2)
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

  test "should follow a user the standard way" do
    assert_difference '@user.friends.count', 1 do
      post relationships_path, followed_id: @other.id
    end
  end

  #test "should follow a user with Ajax" do
  #  assert_difference '@user.following.count', 1 do
  #    xhr :post, relationships_path, followed_id: @other.id
  #  end
  #end

  test "should unfollow a user the standard way" do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@user.friends.count', -1 do
      delete relationship_path(relationship)
    end
  end

  #test "should unfollow a user with Ajax" do
  #  @user.follow(@other)
  #  relationship = @user.active_relationships.find_by(followed_id: @other.id)
  #  assert_difference '@user.following.count', -1 do
  #    xhr :delete, relationship_path(relationship)
  #  end
  #end
end