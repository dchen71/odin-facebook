require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  def setup
  	@like = Like.new(user_id: 1, likeable_id: 1, likeable_type: 'Post')
  end

  test 'validates presence of likeable' do
  	@like.likeable_id = " "
  	@like.likeable_type = " "
  	assert_not @like.valid?
  end

  test 'validates uniqueness of user id and likeable' do
  	@like.save
  	assert_not @like.valid?
  end
end
