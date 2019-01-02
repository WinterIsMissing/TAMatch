require 'spec_helper'


RSpec.describe WidgetsController, :type => :controller do
  describe ".login" do
    it "Should Log In" do
        
        
        
        
    end
    
    it " Should re-direct to the home page" do
       expect(response).to redirect_to(location)   # wraps assert_redirected_to
        
        
        
    end
    
    it " Should store our username" do
        current_user.should eq("admin")
        
        
        
    end
    
    
  end
end