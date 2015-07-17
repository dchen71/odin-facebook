class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update, :destroy]


	def create
		@comment = current_user.comments.build(comment_params)
		@comment.post_id = params[:id]

		if @comment.save
			flash[:success] = "Comment sucessfully added"
			redirect_to comments_post_path
		else
			flash[:error] = 'Error commenting'
			redirect_to comments_post_path
		end
	end

	def edit
		@comment = Comment.find_by(id: params[:id])
	end

	def update
		@comment = Comment.find_by(id: params[:id])

		if @comment.update(comment_params)
			flash[:success] = "Comment successfully updated"
			redirect_to comments_post_path(@comment.post_id)
		else
			flash.now[:error] = "Error updating comment"
			render 'edit'
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])

		if @comment.destroy
			flash[:success] = "Comment successfully deleted"
			redirect_to comments_post_path(@comment.post_id)
		else
			flash[:error] = "Error deleting comment"
			redirect_to comments_post_path(@comment.post_id)
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end

# Confirms the correct user.
    def correct_user
      @comment = Comment.find(params[:id])
      @user = User.find_by(id: @comment.user_id)
      redirect_to(root_url) unless current_user == @user
    end		
end
