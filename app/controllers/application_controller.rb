class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  before_action :have_login

  def have_login
  	redirect_to login_path, alert: "You must login first" unless session[:user_id]
  end
end
