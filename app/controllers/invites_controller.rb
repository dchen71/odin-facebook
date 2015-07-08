class InvitesController < ApplicationController
	def create
		@user = User.find_by(id: params[:invite_id])
		@invite = @user.invites.build(user_id: current_user.id)
		if @invite.save
			flash[:success] = "Successfully sent friend request!"
			redirect_to users_path
		else
			flash[:error] = "Error sending friend request!"
			redirect_to users_path
		end
	end

	def destroy
		@invite = Invite.where(invite_id: current_user.id).find_by(user_id: params[:id]).destroy
		flash[:success] = "Rejected friend request!" 
		redirect_to invites_user_path(current_user.id)
	end

end
