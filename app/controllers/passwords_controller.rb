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
		  				redirect_to index_path, notice: "密码更改成功！"
		  			else
		  				flash.now[:alert] = "密码更改失败，请重试！"
		  				render :edit
		  			end
		  		else
		  			flash.now[:alert] = "两次新密码不一样！"
		  			render :edit
		  		end
  			else
  				flash.now[:alert] = "密码长度必须大于6"
  				render :edit
  			end
  		else
  			flash.now[:alert] = "请输入新密码！"
  			render :edit
  		end
  	else
  		flash.now[:alert] = "当前密码错误！"
  		render :edit
  	end
  end

  def reset
    user = User.find_by_id(params[:id])
    user.password = "999999"
    if user.save
      redirect_to users_path, notice: "#{user.name}'s 的密码修改成功！"
    else
      redirect_to users_path, alert: "密码更改失败，请重试！"
    end
  end
end
