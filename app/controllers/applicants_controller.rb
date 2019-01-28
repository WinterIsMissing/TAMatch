class ApplicantsController < ApplicationController
    
    
    def index

        # Will render a page thanking you for submitting your application
        #render plain: params[:article].inspect
    end
    
    
    def new 
        # Will render the form to apply
    end
    
    def create
        
        
        @email = User.find_by(login_token: session[:user_token]).email
        @name = User.find_by(login_token: session[:user_token]).fullname

        data = JSON.parse(params["application"]["payload"])
        @applicant = Applicant.new
        
        @applicant.name = @name
        @applicant.email = @email
        @applicant.advisor =  data["advisor"]
        @applicant.years = data["years"].to_i
        @applicant.degree_program = data["degree_program"]
        @applicant.isGrader = data["isGrader"]
        @applicant.isSG = data["isSg"]
        @applicant.isTA = data["isTA"]
        @applicant.preferences = data["preferences"]
        @applicant.antipref = data["antipref"]
        @applicant.indifferent = data["indifferent"]
        
        @applicant.save!
        
        puts 'Testing the array mechanisms'
        
        redirect_to applicants_path
        
    end
    
    
    
    def submitted
        @email = User.find_by(login_token: session[:user_token]).email
        
        # get all the applications this user has
        @applications = Applicant.where(:email => @email)
  
    end
    
    
    
    
    
    
    
end
