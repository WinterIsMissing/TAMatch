class MatchmakerController < ApplicationController
  def index
    # @entries = User.all
    @entries = Hash.new
    @data = Hash.new
    @courses = Hash.new
    
    if !Match.first
      @data = Matchmaker.course_match(Course.all, Applicant.all)
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
      :applicants => Applicant.all, :matches => @data
    })[0]
    
=begin
    @data.each do |k, email|
      # last "-"" is delimiter: [COURSE]-[SLOT#]
      delim = k.rindex(/\-/)
      @course_label = k[0,delim]
      slot = k[delim+1]
      @courses[@course_label] = Course.find_by(name: @course_label)
      if !@entries.key?(@course_label)
        @entries[@course_label] = []
      end
      @entries[@course_label] << email
    end
    # @entries = User.all
=end
  end
  
  def refresh_match
    Match.destroy_all
    redirect_to matchmaker_index_path
  end
  
  def change_match
    course = params[:preference][:course]
    email = params[:preference][:email]
    match = Match.find{|m| m.applicant.email == email}
    if match
      #Wait for fix to score function to not break for imperfection case
      #match.course = course
      #match.save
    end
  end
end
