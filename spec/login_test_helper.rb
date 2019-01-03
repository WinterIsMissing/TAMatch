module LoginTestHelper   
  def login_admin
    login(:admin)
  end

  def login(email)
    if !email.nil? && email.to_s =~ /^(.+)@tamu.edu$/
      user = $1
      user = User.where(:login => user).first
      request.session[:user] = user.id
    end
  end

  def current_user
    return User.find(request.session[:user])
  end
end




