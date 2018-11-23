class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  def index
    @users = User.all

  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "新增使用者成功"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    user_name = @user.name
    @user.destroy
    redirect_to admin_users_path, alert: "使用者(#{user_name})已刪除"
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :title, :password, :password_confirmation)
  end

end
