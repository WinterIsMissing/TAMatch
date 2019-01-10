class MatchmakerController < ApplicationController
  def index
    # @entries = User.all
    @data= Matchmaker.course_match(Course.all, Applicant.all)
    @entries = Hash.new
    @data.each do |k, email|
      @course = k[0,3]
      @slot = k[4].to_i
      puts '-----'
      puts @course
      puts @slot
      if !@entries.key?(@course)
        @entries[@course] = []
      end
      @entries[@course] << email
    end
    # @entries = User.all
  end
end
