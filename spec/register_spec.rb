require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'


RSpec.describe "Register page", :type => :feature do
  it 'displays the register page' do
    visit('https://young-lowlands-69353.herokuapp.com/register')
    expect(page.title).to have_content("Welcome to TAnder!")
    expect(page).to have_content("Register")
  end
  it 'contains "full name" field' do
    visit('https://young-lowlands-69353.herokuapp.com/register')
    expect(page).to have_content("Fullname")
    expect(page).to have_field("user_fullname")
  end
  it 'contains "username" field' do
    visit('https://young-lowlands-69353.herokuapp.com/register')
    expect(page).to have_content("Username")
    expect(page).to have_field("user_username")
  end
  it 'contains "email" field' do
    visit('https://young-lowlands-69353.herokuapp.com/register')
    expect(page).to have_content("Email")
    expect(page).to have_field("user_email")
  end
  it "'s all 3 field is fillable" do
    visit('https://young-lowlands-69353.herokuapp.com/register')
    fill_in 'user_email', with: 'HiProfRitchey@gmail.com'
    fill_in 'user_username', with: 'SGARSF SFGSRGWGGSDg'
    fill_in 'user_fullname', with: 'BGFJFD FGSDGSVBSDGB'
    expect(page).to have_field("login_email", with: 'HiProfRitchey@gmail.com')
    expect(page).to have_field("login_username", with: 'SGARSF SFGSRGWGGSDg')
    expect(page).to have_field("login_fullname", with: 'BGFJFD FGSDGSVBSDGB')
  end

end