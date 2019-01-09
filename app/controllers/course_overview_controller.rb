class CourseOverviewController < ApplicationController
  def index
    @course =  params[:search][:query]
    @instructors = User.where(auth_level: 'instructor')
  end
end
