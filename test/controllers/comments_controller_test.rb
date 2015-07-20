require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
  	@comment = comments(:com1)
  	@user = users(:user3)
  end

  test 'redirect from create if not logged in' do
  	patch :update, id: @comment, comment: {content: @comment.content, 
  										   post_id: @comment.post_id, user_id: @comment.user_id}
    assert_redirected_to new_user_session_path
  end

  test 'redirect from edit if not logged in' do
  	get :edit, id: @comment
    assert_redirected_to new_user_session_path
  end

  test 'redirect destroy if not logged in' do
  	delete :destroy, id: @comment
    assert_redirected_to new_user_session_path
  end

  test 'redirect create if not logged in' do
  	post :update, id: @comment, comment: {content: @comment.content, 
  										   post_id: @comment.post_id, user_id: @comment.user_id}
    assert_redirected_to new_user_session_path
  end

  test 'redirect update if incorrect user' do
  	sign_in @user
  	patch :update, id: @comment, comment: {content: @comment.content, 
  										   post_id: @comment.post_id, user_id: @comment.user_id}
    assert_redirected_to root_path
  end

  test 'redirect edit if incorrect user' do
  	sign_in @user
  	get :edit, id: @comment
    assert_redirected_to root_path
  end

  test 'redirect destroy if incorrect user' do
  	sign_in @user
  	delete :destroy, id: @comment
    assert_redirected_to root_path
  end

end
