require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'uri'
require 'cgi'

RSpec.describe "course_overview", :type => :feature do

  it 'unable to direct to matchmaker page (student)' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).not_to have_content("Matchmaker")
  end
  it 'unable to direct to matchmaker page (instructor)' do 
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).not_to have_content("Matchmaker")
  end
  it 'directs to matchmaker page (admin)' do 
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Matchmaker")
    visit matchmaker_index_path
    expect(page).to have_content("Matchmaker")
  end
  it 'updates results' do 
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    visit matchmaker_index_path
    find('input[value="Run Matchmaker"]').click
    expect(page).to have_content("100")
  end
  it 'changes results' do
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    visit matchmaker_index_path
    fill_in 'preference_course', with: '121'
    fill_in 'preference_email', with: "sample.student.1@tamu.edu"
    find('input[value="Submit"]').click
    visit matchmaker_index_path
    fill_in 'preference_course', with: '121'
    fill_in 'preference_email', with: "sample.student.63@tamu.edu"
    find('input[value="Submit"]').click
    visit matchmaker_index_path
    fill_in 'preference_course', with: ''
    fill_in 'preference_email', with: "sample.student.2@tamu.edu"
    find('input[value="Submit"]').click
    visit matchmaker_index_path
    visit matchmaker_index_path
    find('input[value="Run Matchmaker"]').click
    visit matchmaker_index_path
    fill_in 'query_text', with: '11'
    find('input[value="Search"]').click
    expect(page).to have_content("11")
  end
end