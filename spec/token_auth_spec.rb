require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'


RSpec.describe "Email token auth layer", :type => :feature do
  it 'authenticates at the right root path' do
    visit('https://young-lowlands-69353.herokuapp.com/')
    expect(page.title).to have_content("Welcome to TAnder!")
  end
  it 'fuzz test for login token' do
    fuzz = SecureRandom.urlsafe_base64(20)
    visit("https://young-lowlands-69353.herokuapp.com/auth?#{fuzz}")
    expect(page).to have_content("It seems your link is invalid. Try requesting for a new login link")
  end
end