require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'uri'
require 'cgi'

RSpec.describe "Dashboard", :type => :feature do

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
    expect(page).to have_content("Submitted Applications")
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
    expect(page).to have_content("Rank Applications")
  end
  it 'directs to correct dashbaord page (admin)' do 
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Admin")
    expect(page).to have_field("search_query")
  end
  it 'Create Application button test' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Create Application")
    find('a[href$="/applicants/new"]').click
    expect(current_path).to eq('/applicants/new')
  end
  it 'Rank Applications button test' do 
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Rank Applications")
    find('a[href$="/prof_ranking/index"]').click
    expect(current_path).to eq('/prof_ranking/index')
  end
  it 'Admin page form functions' do
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    fill_in 'search_query', with: 'CSCE110'
    expect(page).to have_field("search_query", with: 'CSCE110')
  end  
  it 'block access without token' do
    visit '/dashboard'
    expect(page).to have_content("Please login")
  end  
=begin  
  it 'block access for invalid auth level' do
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token 
    visit '/applicants/new'
    expect(page).to have_content("Inaccessible Page! (student)")
  end  
=end


end