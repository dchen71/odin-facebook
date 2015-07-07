class UsersController < ApplicationController
	before_action :authenticate_user!, :except => :new

	def index
		@users = User.paginate(page: params[:page], per_page: 10)
	end

	def show
		@user = User.find_by(id: params[:id])
		@posts = @user.posts.paginate(page: params[:page], per_page: 10)
	end

	#User.last.create(invite_id: User.first.id)
	#user first has invitation, user last has it in friends list
end
