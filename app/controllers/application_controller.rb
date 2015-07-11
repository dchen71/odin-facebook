class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  private
  #Checks if the logged in user is the same as the user for a page
  def correct_user
   	  @user = User.find(params[:id])
   	  redirect_to(root_url) unless current_user == @user
   end	
end
