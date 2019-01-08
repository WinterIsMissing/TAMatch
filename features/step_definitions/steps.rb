require 'uri'
require 'cgi'

Given(/^that I am an? (.*?)$/) do |role|
    @role = role
end

When(/^I login as "(.*?)"$/) do |email|
    begin
        @user = User.find_by(email: email)
    rescue
        puts "Did you seed the test db? 'rails db:migrate RAILS_ENV=test'"
    end
    token = @user.generate_login_token
    visit '/auth?' + token
end
 
Then(/^I should see "(.*?)"$/) do |text|
    expect(page.has_content?(text)).to eq true
end