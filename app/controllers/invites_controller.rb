class InvitesController < ApplicationController
	def create
		@invite = current_user.invites.build(user_id: params[:id])
		if @invite.save
			flash[:success] = "Successfully sent friend request!"
			redirect_to users_path
		else
			flash[:error] = "Error sending friend request!"
			redirect_to users_path
		end
	end
end
