
require 'spec_helper'
require 'capybara/rspec'


describe "GET TAMAtch homepage", :type => :feature do
  it 'welcomes the user to our homepage' do
    visit('https://young-lowlands-69353.herokuapp.com/')
    expect(page.title).to have_content("Welcome")
    puts " In the homepage "
  end
end