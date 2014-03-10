class PasswordsController < ApplicationController
  def edit
  end

  def update
  	if user = User.authenticate(current_user.name, params[:user][:password])
  		if params[:user][:password_new].present?
  			if params[:user][:password_new].length >= 6
  				if params[:user][:password_new] == params[:user][:password_new_confirmation]
		  			user.password = params[:user][:password_new]
		  			if user.save
		  				redirect_to index_path, notice: "Password was successfully updated!"
		  			else
		  				flash.now[:alert] = "Password was updated fail, please try again!"
		  				render :edit
		  			end
		  		else
		  			flash.now[:alert] = "Two new password is not the same!"
		  			render :edit
		  		end
  			else
  				flash.now[:alert] = "The length of new password must more than 6 !"
  				render :edit
  			end
  		else
  			flash.now[:alert] = "Please input the new password!"
  			render :edit
  		end
  	else
  		flash.now[:alert] = "Current password is wrong!"
  		render :edit
  	end
  end

  def reset
  end
end
