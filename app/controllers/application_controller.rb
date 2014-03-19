class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :first_user, :have_login, :resources

  def have_login
  	redirect_to login_path, alert: "请先登录" unless session[:user_id]
  end
  def first_user
  	User.create(name: "admin", email: "admin@admin.com", admin: true, password: "999999") if User.count.zero?
  end
  def resources
    @users = User.all
  end
  
end
