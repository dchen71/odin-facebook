class RelationshipsController < ApplicationController
	def destroy
		@relationship = Relationship.find_by(id: params[:id])
		@other_user = User.find_by(id: @relationship.user_id)
		current_user.unfriend(@other_user)
		flash[:success] = "User successfully unfriended"
		redirect_to(:back)
	end

	def create
		@invite = Invite.find_by(id: params[:invite_id])
		@user = User.find_by(id: @invite.user_id)
		current_user.friend(@user)
		current_user.reject(@user)
		flash[:success] = "Friend sucessfully added"
		redirect_to(:back)
	end

end
