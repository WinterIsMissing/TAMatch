class UsersController < ApplicationController

  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.auth_level = "student"
    @user.send_login_link(params["user"]["email"])
    redirect_to root_path, notice: 'Welcome! We have sent you the link to login to our app'
  end

  private

  def user_params
    params.require(:user).permit(:fullname, :username, :email)
  end
end
