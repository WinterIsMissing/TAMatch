require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'uri'
require 'cgi'

RSpec.describe "instructor_view", :type => :feature do

  it 'unable to direct to instructor listing page (student)' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).not_to have_content("Instructor Listing")
  end
  it 'unable to direct to instructor listing page (instructor)' do 
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).not_to have_content("Instructor Listing")
  end
  it 'directs to instructor listing page (admin)' do 
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Instructor Listing")
  end
  it 'add an instructor successfully' do
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Instructor Listing")
    visit '/instructors/index'
    fill_in 'search_query', with: 'test_s2@x.x'
    find('input[name="commit"]').click
    expect(page).to have_content("Added test_s2@x.x")
  end
  it 'add an instructor as a new instructor unsuccessfully' do
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Instructor Listing")
    visit '/instructors/index'
    fill_in 'search_query', with: 'test_i@x.x'
    find('input[name="commit"]').click
    expect(page).to have_content("role is instructor or higher")
  end
  it 'add a nonexistent user as new instructor unsuccessfully' do
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Instructor Listing")
    visit '/instructors/index'
    fill_in 'search_query', with: 'nil@x.x'
    find('input[name="commit"]').click
    expect(page).to have_content("Could not find")
  end
  it 'remove a nonexistent user as an instructor unsuccessfully' do
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Instructor Listing")
    visit '/instructors/index'
    visit instructors_remove_path(:email => "nil@x.x")
    expect(page).to have_content("Could not find")
  end
  it 'remove an admin as an instructor unsuccessfully' do
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Instructor Listing")
    visit '/instructors/index'
    visit instructors_remove_path(:email => "test_a@x.x")
    expect(page).to have_content("role is admin")
  end
  it 'remove an instructor unsuccessfully' do
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Instructor Listing")
    visit '/instructors/index'
    visit instructors_remove_path(:email => "test_i@x.x")
    expect(page).to have_content("Removed test_i@x.x")
  end
end