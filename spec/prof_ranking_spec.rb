require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'uri'
require 'cgi'

RSpec.describe "course_overview", :type => :feature do

  it 'unable to direct to Instructor Preferences page (student)' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).not_to have_content("Rank Applications")
  end
  
  it 'directs to Instructor Preferences page (instructor)' do 
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Rank Applications")
    visit prof_ranking_index_path
    expect(page).to have_content("Instructor Preferences")
  end
  
  it 'unable to direct to Instructor Preferences page (admin)' do 
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).not_to have_content("Rank Applications")
  end
  
  it 'rate in Instructor Preferences page (instructor)' do 
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Rank Applications")
    visit prof_ranking_index_path
    expect(page).to have_content("Instructor Preferences")
    button = find('tr:nth-child(2) input[value="2"]')
    student_email = button[:email]
    fill_in 'preference_rating', with: '2'
    fill_in 'preference_email', with: student_email
    find('input[name="commit"]').click
    user = User.find_by(email: email)
    expect user.instructor_preference.preferences[email] == '2'
    visit prof_ranking_index_path
    fill_in 'preference_rating', with: '4'
    fill_in 'preference_email', with: student_email
    find('input[name="commit"]').click
    expect user.instructor_preference.preferences[email] == '4'
  end
end