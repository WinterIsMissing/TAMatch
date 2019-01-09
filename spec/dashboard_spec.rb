require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'uri'
require 'cgi'

RSpec.describe "dashboard", :type => :feature do

  it 'directs to dashbaord page' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Dashboard")
    expect(page).to have_content("Messages")
    expect(page).to have_content("Logout")
    expect(page).to have_content("Account")
  end
  it 'directs to correct dashbaord page (student)' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Student")
    expect(page).to have_content("Accepted Applications")
    expect(page).to have_content("Pending Applications")
    expect(page).to have_content("Create Application")
  end
  it 'directs to correct dashbaord page (instructor)' do 
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Instructor")
    expect(page).to have_content("Add Posting")
    expect(page).to have_content("View Postings")
  end
  it 'directs to correct dashbaord page (admin)' do 
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Admin")
  end
  

end