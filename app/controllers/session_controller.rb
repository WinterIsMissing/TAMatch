class SessionController < ApplicationController
  def auth
    token =  params.keys[0]

    user = User.find_by(login_token: token)
    if !user
      redirect_to root_path, notice: 'It seems your link is invalid. Try requesting for a new login link'
    elsif user.login_token_expired?
      redirect_to root_path, notice: 'Your login link has been expired. Try requesting for a new login link.'
    else
      sign_in_user(user)
      redirect_to dashboard_path, notice: 'You have been signed in!'
      #redirect_to root_path, notice: 'You have been signed in!'
    end
  end
  
  #For email authentication
  def create
    puts params
    value = params[:value].to_s
    user = User.find_user_by(value)

    if !user
      redirect_to root_path, notice: "Uh oh! We couldn't find the username / email. Please try again."
    else
      user.send_login_link
      redirect_to root_path, notice: 'We have sent you the link to login to our app'
    end
  end
  
  def send_link
    value = params["login"]["email"]
    user = User.find_by(email: value)
    
    if !user
      redirect_to root_path, notice: "Uh oh! We couldn't find the username / email. Please try again."
    else
      user.send_login_link(user)
      redirect_to root_path, notice: 'We have sent you the link to login to our app'
    end
  end
  
  def create_oauth
  begin
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = @user.id
    flash.now[:success] = "Welcome, #{@user.name}!"
   rescue
    flash.now[:warning] = "There was an error while trying to authenticate you..."
  end
    redirect_to root_path, notice: 'Login via Google successful'
  end
end
