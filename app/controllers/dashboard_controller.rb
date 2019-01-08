class DashboardController < ApplicationController
    
    def index
        @id = session[:user_token]
        @student = true
=begin
        @user = User.find_by(login_token: @id)
        case @user.auth_level
        when "admin"
            @admin = true
        when "instructor"
            @instructor = true
        else "student"
            @student = true
        end
=end
    end
    
end
