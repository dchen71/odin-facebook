class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@comment = current_user.comments.build(comment_params)
		
		if @comment.save
			flash[:success] = "Comment sucessfully added"
			redirect_to comments_post_path
		else
			flash[:error] = "Error adding comment"
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
			redirect_to comments_post_path
		else
			flash.now[:error] = "Error updating comment"
			render 'edit'
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])

		if @comment.destroy
			flash[:success] = "Comment successfully deleted"
			redirect_to comments_post_path
		else
			flash[:error] = "Error deleting comment"
			redirect_to comments_post_path
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:content, :id, :post_id, :user_id)
	end
end
