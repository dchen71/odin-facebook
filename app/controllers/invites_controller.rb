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


	#User.last.invites.create(user_id: User.first.id)
	#user_id will be inviting user.last
	#User.where("id = ?", User.first.invites.first.user_id)
end
