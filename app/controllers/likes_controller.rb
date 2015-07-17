class LikesController < ApplicationController
	before_action :correct_user

	def create

	end

	def destroy

	end

# Confirms the correct user.
	private
    def correct_user
      @like = Like.find(params[:id])
      @user = User.find_by(id: @like.user_id)
      redirect_to(root_url) unless current_user == @user
    end		
end
