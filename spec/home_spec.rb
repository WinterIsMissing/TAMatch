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
    expect(page).to have_content("Sign in via Google")
  end
  it 'contains register link for new users' do
    visit('https://young-lowlands-69353.herokuapp.com/')
    expect(page).to have_content("Register!")
  end
  it 'contains email login link field' do
    visit('https://young-lowlands-69353.herokuapp.com/')
    expect(page).to have_field("login_email")
  end
  it "'s email login field works" do
    visit('https://young-lowlands-69353.herokuapp.com/')
    fill_in 'login_email', with: 'HiProfRitchey@gmail.com'
    expect(page).to have_field("login_email", with: 'HiProfRitchey@gmail.com')
  end
  it "'s email login field submit button works (nothing filled)" do
    visit('https://young-lowlands-69353.herokuapp.com/')
    find('input[name="commit"]').click
    expect(page).to have_content("Uh oh! We couldn't find the username / email. Please try again.")
  end
  it "'s email login field submit button works (something wrong filled)" do
    visit('https://young-lowlands-69353.herokuapp.com/')
    fill_in 'login_email', with: 'HiProfRitchey@GGmail.commm666'
    expect(page).to have_field("login_email", with: 'HiProfRitchey@GGmail.commm666')
    find('input[name="commit"]').click
    expect(page).to have_content("Uh oh! We couldn't find the username / email. Please try again.")
  end
  it "'s register link redirect works" do
    visit('https://young-lowlands-69353.herokuapp.com/')
    expect(page).to have_content("Register!")
    find('a[href$="/register"]').click
    expect(current_path).to eq('/register')
  end  
end