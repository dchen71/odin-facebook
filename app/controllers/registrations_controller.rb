class RegistrationsController < Devise::RegistrationsController
	def create
		@user = User.new(sign_up_params)

		if @user.save
			flash[:success] = "User successfully created"
			redirect_to root_path
		else
			flash[:error] = "Error creating user"
			render 'new'
		end
	end

	private

	def sign_up_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end	
end
