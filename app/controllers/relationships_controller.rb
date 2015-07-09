class RelationshipsController < ApplicationController
	def destroy
		@relationship = Relationship.find_by(id: params[:id])
		@other_user = User.find_by(id: @relationship.user_id)
		current_user.unfriend(@other_user)
		flash[:success] = "User successfully unfriended"
		redirect_to friend_list_path(current_user)
	end

end
