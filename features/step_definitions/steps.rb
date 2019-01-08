require 'uri'
require 'cgi'

Given(/^that I am an? (.*?)$/) do |role|
    @role = role
end

When(/^I login as "(.*?)"$/) do |email|
    begin
        @user = User.find_by(email: email)
        token = @user.generate_login_token
        visit '/auth?' + token
    rescue
        puts "##Did you seed the test db? THANKS AND GIG'EM!##"
        raise "##Make sure to seed the test db: 'rails db:seed RAILS_ENV=test'##"
    end
end
 
Then(/^I should see "(.*?)"$/) do |text|
    begin
        expect(page.has_content?(text)).to eq true
    rescue
        raise "Did you seed the test db? 'rails db:migrate RAILS_ENV=test'"
    end
end