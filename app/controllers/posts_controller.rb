class PostsController < ApplicationController
	def index
		@posts = current_user.posts.paginate(page:params[:page],per_page:10)
	end

	def create
		@post = current_user.posts.build(content: params[:content])

		if @post.save
			flash[:success] = "Post sucessfully added"
			redirect_to posts_path
		else
			flash[:error] = "Error creating post"
			redirect_to posts_path
		end
	end
end
