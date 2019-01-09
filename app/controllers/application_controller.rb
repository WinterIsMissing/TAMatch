require 'passwordless'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include Passwordless::ControllerHelpers
  helper_method :current_user
  before_action :require_token!
  def sign_in_user(user)
    user.expire_token!
    user.generate_login_token
    user.expire_token!
    session[:user_token] = user.login_token
  end

  
  def require_token!
    return if ['static', 'session', 'users'].include? params[:controller]
    return if params[:controller] == "static" || (session[:user_token] && User.find_by(login_token: session[:user_token]))
    redirect_to root_path, notice: 'Please login'
  end  
end
