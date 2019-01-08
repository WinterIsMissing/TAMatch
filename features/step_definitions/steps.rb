require 'uri'
require 'cgi'

Given(/^that I am an? (.*?)$/) do |role|
    @role = role
end

When(/^I login as "(.*?)"$/) do |email|
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
end
 
Then(/^I should see "(.*?)"$/) do |text|
    expect(page.has_content?(text)).to eq true
end