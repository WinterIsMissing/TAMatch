DEF_COURSE = "121"
class ProfRankingController < ApplicationController
  def index
    @applicants = nil
    query = params[:search]
    query ||= session[:ip_search]
    course = params[:course]
    course ||= session[:ip_course]
  
    if !(params[:search].nil? || params[:course].nil?)
      if query == "default"
        @applicants = Applicant.where("'#{course}' = ANY(preferences)")
        #Sort
      else
        @applicants = Applicant.all
      end
      @applicants = @applicants.sort_by { |applicant|
        applicant.preferences.index(course) or (1.0/0.0)
      }
    else
      if query.nil? then query = "default" end
      if course.nil? then course = DEF_COURSE end
      redirect_to prof_ranking_index_path(:search => query, :course => course, 
        :name => session[:ip_name], :advisor => session[:ip_advisor])
    end
    
    #Name
    if @applicants and params[:name]
      @applicants = @applicants.find_all{|x| x.name.include? params[:name]}
    end
    
    #Advisor
    if @applicants and params[:advisor]
      @applicants = @applicants.find_all{|x| x.advisor.include? params[:advisor]}
    end
    
    #Preferences
    ip = User.find_by(login_token: session[:user_token]).instructor_preference
    preferences = ip.nil? ? {} : ip.preferences
    preferences ||= {}
    
    @preferences = preferences
    
    session[:ip_search] = query
    session[:ip_course] = course
  end
  
  def search
    if params[:query]
      course = params[:query][:course]
      name = params[:query][:name]
      advisor = params[:query][:advisor]
      if course and !course.empty?
        session[:ip_course] = course
      end
      if name
        session[:ip_name] = name
      else
        session.delete(:ip_name)
      end
      if advisor
        session[:ip_advisor] = advisor
      else
        session.delete(:ip_advisor)
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
end
