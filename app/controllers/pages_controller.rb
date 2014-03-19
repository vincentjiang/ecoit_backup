class PagesController < ApplicationController

	skip_before_action :have_login
	
  def index
  end

  def help
  end
end
