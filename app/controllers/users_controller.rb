class UsersController < ApplicationController
  
  layout 'main', only: :index

  before_action :is_admin, only: [:index, :new, :create, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :only_update_yourself, only: [:edit, :update]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(:name)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(create_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: "用户 #{@user.name} 创建成功！" }
        format.json { render action: 'index', status: :created, location: @users }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|

      if current_user.admin && @user != current_user
        update_params = params.require(:user).permit(:email, :admin)
        if @user.update(update_params)
          format.html { redirect_to users_path, notice: "用户 #{@user.name} 修改成功！" }
        else
          format.html { render action: 'edit' }
        end

      elsif current_user.admin && @user == current_user
        update_params = params.require(:user).permit(:email)
        if @user.update(update_params)
          format.html { redirect_to edit_user_path(current_user), notice: "用户 #{@user.name} 修改成功！" }
        else
          format.html { render action: 'edit' }
        end

      else
        update_params = params.require(:user).permit(:email)
        if @user.update(update_params)
          format.html { redirect_to edit_user_path(current_user), notice: "用户 #{@user.name} 修改成功！" }
        else
          format.html { render action: 'edit' }
        end

      end

    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "用户 #{@user.name} 删除成功！" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def create_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def is_admin
      redirect_to index_path, alert: "您不是管理员！" unless current_user.admin
    end

    def only_update_yourself
      redirect_to edit_user_path(current_user), alert: "您不能修改别人的资料！" if !current_user.admin && @user != current_user
    end
    
end
