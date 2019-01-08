require 'login_test_helper'
require 'spec_helper'
require 'login_controller'

RSpec.describe LoginController, :type => :controller do
  describe "User Login Functionality" do
    it "User can log in" do
      post :login, email: "test0105@tamu.edu"
      expect(response).to redirect_to("/dashboard")
    end
    
    it "User puts in invalid email" do
      post :login, email: "test@foo.edu"
      expect(response).to redirect_to("/index")
    end

    it "Should re-direct to the dashboard page" do
      login("test0105@tamu.edu")
      expect(response).to redirect_to("/dashboard")
    end
    
    it " Should store our username" do
      login("test0105@tamu.edu")
      current_user.should eq("test")
    end
    
    it "Should not set session username if bad email" do
      login("test@foo.edu")
      current_user.should.be_nil
    end
  end
end