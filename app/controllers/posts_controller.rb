class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update, :destroy]

	def index
		@posts = current_user.feed.reorder("created_at DESC").paginate(page:params[:page],per_page:10)
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
		@post = Post.find_by(id: params[:id])
	end

	def update
		@post = Post.find_by(id: params[:id])

		if @post.update(post_params)
			flash[:success] = "Post successfully updated"
			redirect_to posts_path
		else
			flash.now[:error] = "Error updating post"
			render 'edit'
		end
	end

	def destroy
		@post = Post.find_by(id: params[:id])

		if @post.destroy
			flash[:success] = "Post successfully deleted"
			redirect_to posts_path
		else
			flash.now[:error] = "Error deleting post"
			render 'index'
		end
	end


	def comments
		@post = Post.find_by(id: params[:id])
		@comments = @post.comments.paginate(page: params[:page], per_page: 10)
		@comment = current_user.comments.build()
	end

  private
    def post_params
      params.require(:post).permit(:content)
    end	

# Confirms the correct user.
    def correct_user
      @post = Post.find(params[:id])
      @user = User.find_by(id: @post.user_id)
      redirect_to(root_url) unless current_user == @user
    end		
end
