class CoursesController < ApplicationController
    #FYI Applicants != Application
    
    def index
        @courses = Course.order(:position)
    end
    
    
    def new
        @courses = Course.order(:position)
    end
    
    
    def create
        @course = Course.order(:position)
        #@applicant = Applicant.new(degree_program: params["applicant"]["degree_program"])
        #@applicant.save!
        
        redirect_to @course
    end
    
    
    def show
        #puts params
        @course = Course.find(params[:id])
        #puts "in show"
    end
    
    
    def sort
        #puts "IN SORT"
        params[:course].each_with_index do |id, index|
            Course.where(id: id).update_all(position: index + 1)
        end

        head :ok
        
    end
    
    
    
    
    
    
    
    
    
end
