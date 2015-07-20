class LikesController < ApplicationController
	before_action :correct_user, only: :destroy

  	def create
	  	  @like = current_user.likes.build(likeable_id: params[:likeable_id],
	  	  								   likeable_type: params[:likeable_type])
	
	  	  if @like.save
	  	    flash[:success] = "Liked!"
	  	    redirect_to(:back)
	  	  else
	  	    flash[:error] = "Error liking"
	  	    redirect_to(:back)
	  	  end
	  	end

	def destroy
		@like = current_user.likes.find_by(likeable_id: params[:likeable_id],
										   likeable_type: params[:likeable_type])

		if @like.destroy
			flash[:success] = "Successfully unliked"
			redirect_to(:back)
		else
			flash[:error] = "Error liking"
			redirect_to(:back)
		end
	end

# Confirms the correct user.
	private
    def correct_user
      @like = Like.find_by(id: params[:id])
      @user = User.find_by(id: @like.user_id)
      redirect_to(root_url) unless current_user == @user
    end		
end
