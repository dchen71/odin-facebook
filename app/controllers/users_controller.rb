class UsersController < ApplicationController
	before_action :authenticate_user!, :except => :new
	before_action :correct_user, only: [:invites]

	def index
		@users = User.where.not(id: current_user.id).paginate(page: params[:page], per_page: 10)
	end

	def show
		@user = User.find_by(id: params[:id])
		@posts = @user.posts.paginate(page: params[:page], per_page: 10)
	end

	def invites
		@user = User.find_by(id: params[:id])
		@invites = @user.invites.paginate(page: params[:page], per_page: 10)
		@friend = current_user.friends.build
	end

	def friends
		@user = User.find_by(id:params[:id])
		@friends = @user.friends.paginate(page:params[:page], per_page: 10)
	end

	private

    	# Confirms the correct user.
    	def correct_user
    	  @user = User.find(params[:id])
    	  redirect_to(root_url) unless current_user == @user
    	end			
end
