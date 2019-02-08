class DashboardController < ApplicationController
    
    def index
        @id = session[:user_token]
  
        @user = User.find_by(login_token: @id)
        case @user.auth_level
        when "admin"
            @admin = true
        when "instructor"
            @instructor = true
        else "student"
            @student = true
            
            @email = User.find_by(login_token: session[:user_token]).email
            # Here, we can check if they already have an applicatin
        
            @application = Applicant.find_by(email: @email)
        
            #puts "In create"
            if @application
                @applicationFound = true
                
            end

        end
        # test = true
        # if test
        #     @admin = true
        #     @instructor = true
        #     @student = true
        # end
    end
    
end
