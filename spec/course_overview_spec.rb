=begin no longer support course_overview page

require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'uri'
require 'cgi'

RSpec.describe "course_overview", :type => :feature do

  it 'unable to direct to course overview page (student)' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).not_to have_content("Course Overview")
  end
  it 'unable to direct to course overview page (instructor)' do 
    email = "test_i@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).not_to have_content("Course Overview")
  end
  it 'directs to course overview page (admin)' do 
    email = "test_a@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Course Overview")
    fill_in 'search_query', with: 'CSCE 313'
    find('input[name="commit"]').click
    expect(page).to have_content("CSCE 313")
  end

end

=end