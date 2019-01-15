class MatchmakerController < ApplicationController
  def index
    # @entries = User.all
    @data= Matchmaker.course_match(Course.all, Applicant.all)
    @entries = Hash.new
    @courses = Hash.new
    @data.each do |k, email|
      # last "-"" is delimiter: [COURSE]-[SLOT#]
      delim = k.rindex(/\-/)
      @course_label = k[0,delim]
      slot = k[delim+1].to_i
      @courses[@course_label] = Course.find_by(name: @course_label)
      if !@entries.key?(@course_label)
        @entries[@course_label] = []
      end
      @entries[@course_label] << email
    end
    # @entries = User.all
  end
end
