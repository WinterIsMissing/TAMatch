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
    if !@user.instructor_preference.nil?
      @user.instructor_preference.destroy
      @user.instructor_preference = nil
    end
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
  
  it 'using different search filters in instructor preference page' do 
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Rank Applications")
    visit prof_ranking_index_path(:years => 0, :yr_cmp => ">")
    expect(page).to have_content("years >")
    visit prof_ranking_index_path(:years => 0, :yr_cmp => "<")
    expect(page).to have_content("years <")
    visit prof_ranking_index_path(:years => 0, :yr_cmp => "=")
    expect(page).to have_content("years =")
    visit prof_ranking_index_path(:advisor => "random")
    expect(page).to have_content("random")
    visit prof_ranking_index_path(:advisor => "random", :years => 0, 
      :yr_cmp => "=", :name => "Student", :course => "121")
    expect(page).to have_content("121")
  end
  
  it 'using search filters modal in instructor preference page' do 
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    visit prof_ranking_index_path
    fill_in 'query_name', with: 'Student'
    fill_in 'query_advisor', with: 'none'
    fill_in 'query_years', with: '3'
    fill_in 'query_course2', with: '462'
    select('<', :from => 'query_yr_cmp')
    find('input[name="adv_search"]').click
    expect(page).to have_content("years < 3")
    find('input[name="adv_search"]').click
    expect(page).not_to have_content("years < 3")
  end
end
