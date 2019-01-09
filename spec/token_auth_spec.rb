require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'time'

RSpec.describe "Authentication layer", :type => :feature do
  it 'authenticates at the right root path' do
    visit('https://young-lowlands-69353.herokuapp.com/')
    expect(page.title).to have_content("Welcome to TAnder!")
  end
  it 'survives brute force attack for login token (100 attempts)' do
    fuzz_list =[]
    (1...100).each do
      fuzz_list << SecureRandom.urlsafe_base64(20)
    end
    fuzz_list.each do |fuzz|
      visit("https://young-lowlands-69353.herokuapp.com/auth?#{fuzz}")
      expect(page).to have_content("It seems your link is invalid. Try requesting for a new login link")
    end  
  end
  it "generates secure tokens (50 attempts)" do
    fuzz_list =[]
    (1...50).each do
      fuzz_list << SecureRandom.urlsafe_base64(20)
    end
    fuzz_list.each do |token|
      token = SecureRandom.urlsafe_base64(20)
      expect(token.length).to be > 20
      checker = StrongPassword::StrengthChecker.new(token)
      expect(checker.is_strong?).to be true 
      expect(checker.calculate_entropy(use_dictionary: true)).to be > 24
    end
  end
  it "handles expired token" do
    email = "test_s@x.x"
    @user = User.find_by(email: email) 
    token = @user.generate_login_token
    @user.expire_token!
    visit '/auth?' + token
    expect(page).to have_content('Your login link has been expired. Try requesting for a new login link.')
  end
end