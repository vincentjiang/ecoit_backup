class SessionsController < ApplicationController
  skip_before_action :have_login, only: [:new, :create]

  def new
    redirect_to index_path, alert: "您已经登录" if session[:user_id]
  end

  def create
  	if user = User.find_by_name(params[:session][:name].downcase)
  		if user == User.authenticate(user.name, params[:session][:password])
  			session[:user_id] = user.id
  			redirect_to index_path, notice: "登录成功！"
  		else
  			flash.now[:alert] = "密码错误！"
  			render :new
  		end
  	else
  		flash.now[:alert] = "用户名无效！"
  		render :new
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to login_path, notice: "您已成功登出！"
  end
end
