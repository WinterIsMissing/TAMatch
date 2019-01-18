class ApplicantsController < ApplicationController
    
    
    def index

        #render plain: params[:article].inspect
    end
    
    
    def new 
    end
    
    def create
        
        
        @email = User.find_by(login_token: session[:user_token]).email
        @name = User.find_by(login_token: session[:user_token]).fullname
        puts @email
        puts @name
        
       # puts params["application"]["payload"]
        
        
        data = JSON.parse(params["application"]["payload"])
        
        @applicant = Applicant.new
        
        @applicant.name = @name
        @applicant.email = @email
        @applicant.degree_program = data["degree_program"]
        @applicant.isGrader = data["isGrader"]
        @applicant.isSG = data["isSg"]
        @applicant.isTA = data["isTA"]
        @applicant.preferences = data["preferences"]
        @applicant.antipref = data["antipref"]
        @applicant.indifferent = data["indifferent"]
        
        @applicant.save!
        
        puts 'Testing the array mechanisms'
        
        
        
        puts @applicant.isGrader
        puts @applicant.indifferent[0]


        
        
        redirect_to applicants_path
        
    end
    
    
    
    
    
    
    
    
    
    
    
end
