class DashboardController < ApplicationController
    
    def index
        @id = session[:user_id]
        @user = User.find(@id)
        case @user.auth_level
        when "admin"
            @admin = true
        when "instructor"
            @instructor = true
        else "student"
            @student = true
        end
    end
    
end
