DEF_COURSE = "121"
class ProfRankingController < ApplicationController
  def index
    @applicants = nil
    #  we have it stored as CSCE313, not just 313, we can change the design
    
    course = params[:course]
    course ||= session[:ip_course]
    
    @courseConcat = "CSCE" + course
    
    if params[:name] then session[:ip_name] = params[:name] end
    if params[:advisor] then session[:ip_advisor] = params[:advisor] end
    if params[:years] then session[:ip_years] = params[:years] end
    if params[:yr_cmp] then session[:ip_yr_cmp] = params[:yr_cmp] end
    
    if !(params[:course].nil?)
      @applicants = Applicant.where("'#{@courseConcat}' = ANY(preferences)").or Applicant.where("'#{course}' = ANY(preferences)")
      @applicants = @applicants.sort_by { |applicant|
        applicant.preferences.index(course) or (1.0/0.0)
      }
    else
      course ||= DEF_COURSE
      redirect_to prof_ranking_index_path(:course => course, 
        :name => session[:ip_name], :advisor => session[:ip_advisor],
        :years => session[:ip_years], :yr_cmp => session[:ip_yr_cmp])
    end
    
    if @applicants
      #Name
      if params[:name]
        puts "In the name index"
        
        @applicants = @applicants.find_all{|x| x.name.include? params[:name]}
      end
    
      #Advisor
      if params[:advisor]
        @applicants = @applicants.find_all{|x| x.advisor.include? params[:advisor]}
      end
    
      #Years
      years = params[:years]
      yr_cmp = params[:yr_cmp]
      if years and !years.empty? and years.to_i
        yr_cmp and !yr_cmp.empty?
        if yr_cmp == ">"
          @applicants = @applicants.find_all{|x| x.years > years.to_i}
        elsif yr_cmp == "<"
          @applicants = @applicants.find_all{|x| x.years < years.to_i}
        else
          @applicants = @applicants.find_all{|x| x.years == years.to_i}
        end
      end
    end
    #Preferences
    ip = User.find_by(login_token: session[:user_token]).instructor_preference
    preferences = ip.nil? ? {} : ip.preferences
    preferences ||= {}
    
    @preferences = preferences
    
    session[:ip_course] = course
  end
  
  def search
    if params[:query]
      course = params[:query][:course]
      course ||= params[:query][:course2]
      name = params[:query][:name]
      advisor = params[:query][:advisor]
      years = params[:query][:years]
      yr_cmp = params[:query][:yr_cmp]
      
      if course and !course.empty?
        session[:ip_course] = course
      end
      if name
        session[:ip_name] = name
      end
      if advisor
        session[:ip_advisor] = advisor
      end
      if years
        session[:ip_years] = years
      end
      if yr_cmp
        session[:ip_yr_cmp] = yr_cmp
      end
    end
    redirect_to prof_ranking_index_path
  end
  
  def update
    # puts params
    rating = params[:preference][:rating]
    email = params[:preference][:email]
    user = User.find_by(login_token: session[:user_token])
    if user.instructor_preference.nil?
      ip = InstructorPreference.create(user: user)
      ip.preferences = {}
      ip.save!
      # puts ip
    end
    if ip.nil?
      ip = user.instructor_preference
    end
    ip.preferences[email] = rating
    ip.save!
  end
  
  
  
  
  def show


    puts params
    
    @applicant_name = params[:applicant_name]
    
    @applicant_object = Applicant.find_by(name: @applicant_name)
  
    @email = @applicant_object.email
    
    @degree_program =  @applicant_object.degree_program
    @isTA = @applicant_object.isTA
    @isGrader = @applicant_object.isGrader
    @isSG = @applicant_object.isSG
    @preferences = @applicant_object.preferences
    @antipref = @applicant_object.antipref
    @indifferent = @applicant_object.indifferent
    @advisor = @applicant_object.advisor
    @years = @applicant_object.years
    @created_at = @applicant_object.created_at

    @applicant_ = "passed data from controller only"
    
    respond_to do |format|
      format.html
      format.js
    end
    
    
    
  end
  
  
  
  
  
  
end
