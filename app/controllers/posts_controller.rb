class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit]

	def index
		@posts = current_user.posts.paginate(page:params[:page],per_page:10)
		@post = Post.new
	end

	def create
		@post = current_user.posts.build(post_params)
		
		if @post.save
			flash[:success] = "Post sucessfully added"
			redirect_to posts_path
		else
			flash[:error] = "Error adding post"
			redirect_to posts_path
		end
	end

	def edit

	end


  private
    def post_params
      params.require(:post).permit(:content)
    end

# Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user == @user
    end			
end
