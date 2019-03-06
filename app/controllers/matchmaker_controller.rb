class MatchmakerController < ApplicationController
  def index
    
    
    
    # For the export function
    @allApplicants = Applicant.all;
    @allCourses = Course.all;
    @allAdmin = User.all; #FIX ME, not sure what uses are included here admin, instructers, applicants(again?), etc
    @Matches = Match.all;

    
    respond_to do |format|
      format.html
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="MatchMakerData.xlsx"' }
    end
    
    #end of export variables
    
    
    # @entries = User.all
    @entries = Hash.new
    @data = Hash.new
    @courses = Hash.new
    applicants = Applicant.all
    if params[:reset]
      Match.destroy_all
      @data = Matchmaker.course_match(Course.all, applicants)
      @data.each do |key, email|
        delim = key.rindex(/\-/)
        course_label = key[0,delim]
        slot = key[delim+1..-1]
        applicant = Applicant.find_by(email: email)
        Match.create(:course => course_label, :label => slot, :applicant => applicant)
      end
    else
      Match.all.each do |match|
        @data["#{match.course}-#{match.label}"] = match.applicant.email
      end
    end
    
    Match.all.each do |match|
      if !@entries.key?(match.course)
        @entries[match.course] = []
      end
      if !@courses.key?(match.course)
        @courses[match.course] = Course.find_by(name: match.course) 
      end
      @entries[match.course] << Applicant.find_by(email: match.applicant.email)
    end

    @score = Matchmaker.course_match_score({:courses => Course.all,
      :applicants => applicants, :matches => @data
    })[0]
    if @score < 0
      @score = 0.0
    end

    @query_items = []
    if params[:query] and !params[:query].empty?
      @query_items = applicants.find_all{|x| x.name.include? params[:query]}
    end
    
    @non_matched = applicants.find_all{|x| x.match.nil?}
    
    #Fill in Courses w/ 0 applicants
    Course.all.each do |course|
      if !@entries.key?(course.name)
        @entries[course.name] = []
        @courses[course.name] = course
      end
    end
    @entries = @entries.sort.to_h
  end
  
  def refresh_match
    redirect_to matchmaker_index_path(:reset => true)
  end
  
  def change_match
    course = params[:preference][:course]
    email = params[:preference][:email]
    match = Match.find{|m| m.applicant.email == email}
    if !course or course.empty?
      if match
        match.destroy
      end
    else
      if !match
        applicant = Applicant.find_by(email: email)
        if applicant
          match = Match.create(:course => course, :label => "_", :applicant => applicant)
        end
      end
      #Wait for fix to score function to not break for imperfection case
      match.course = course
      match.save
    end
  end
  
  def search
    query = params[:query][:text]
    redirect_to matchmaker_index_path(:query => query)
  end
  
  def export
    #TODO: Export Courses into a .csv or something
    # On Click Export
    
    
    #implemented in the file: index.xslx.axlsx
    
    
    
    
    
  end
  
  def clear
    Match.destroy_all
    redirect_to matchmaker_index_path
  end
end
