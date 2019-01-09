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
   #   puts request.env['omniauth.auth']
  #    puts "HELLO"
      @user = User.from_omniauth(request.env['omniauth.auth'])
     
      @user.generate_login_token
      @user.expire_token!
      
      session[:user_token] = @user.login_token
   #   session[:user_token] = request.env['omniauth.auth'].info.email
      #flash.now[:success] = "Welcome, #{@user.email}!"
   # rescue
    #puts "login error"
     # redirect_to root_path and return
    end
  #  notice: 'Login via Google successful' 
    redirect_to dashboard_path and return 
  end
end
