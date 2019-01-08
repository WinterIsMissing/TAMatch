require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'


RSpec.describe "TAnder homepage", :type => :feature do
  it 'welcomes the user to our homepage' do
    visit('https://young-lowlands-69353.herokuapp.com/')
    expect(page.title).to have_content("Welcome to TAnder!")
  end
  it 'contains Google Oauth login' do
    visit('https://young-lowlands-69353.herokuapp.com/')
    page.should have_content("Sign in via Google")
  end
  it 'contains register link for new users' do
    visit('https://young-lowlands-69353.herokuapp.com/')
    page.should have_content("Register!")
  end
end