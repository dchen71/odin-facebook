class PostsController < ApplicationController
	before_action :authenticate_user!

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


  private
    def post_params
      params.require(:post).permit(:content)
    end
end
