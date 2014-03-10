class SessionsController < ApplicationController
  skip_before_action :have_login, only: [:new, :create]

  def new
  end

  def create
  	if user = User.find_by_name(params[:session][:name].downcase)
  		if user == User.authenticate(user.name, params[:session][:password])
  			session[:user_id] = user.id
  			redirect_to index_path, notice: "Login successfully!"
  		else
  			flash.now[:alert] = "Password is not correct!"
  			render :new
  		end
  	else
  		flash.now[:alert] = "Login name is not correct!"
  		render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to login_path, notice: "You have logouted!"
  end
end
