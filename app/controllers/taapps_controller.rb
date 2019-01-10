class TaappsController < ApplicationController
    def new
        puts "In the routes action"
        #@taapp = Taapp.new
    end
    
    
    def create
        # @taapp = Taapp.new(degreeProgram: params["taapp"]["degreeProgram"])
        # @taapp.save!
        redirect_to ta_application_index_path
        # redirect_to @taapp
    end
    
    
    def show
        @taapp = Taapp.find(params[:id])
        puts "in show"
    end
    
end
