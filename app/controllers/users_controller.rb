class UsersController < ApplicationController
	before_action :authenticate_user!, :except => :new

	def index
		@users = User.paginate(page: params[:page], per_page: 10)
	end

	def show
		@user = User.find_by(id: params[:id])
		@posts = @user.posts.paginate(page: params[:page], per_page: 10)
	end
end
