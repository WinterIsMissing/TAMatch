require 'uri'
require 'cgi'

Given(/^that I am an? (.*?)$/) do |role|
    @role = role
end

When(/^I login as "(.*?)"$/) do |email|
    begin
        @user = User.find_by(email: email)
        if @user
            @user.destroy
        end
    rescue
    end
    visit '/register'
    fill_in 'user_fullname', :with => email
    fill_in 'user_username', :with => email
    fill_in 'user_email', :with => email
    find('input[name="commit"]').click
    puts email
    puts page.html
    @user = User.find_by(email: email)
    @user.role = @role
    @user.save!
    puts @user.email
    visit '/auth?' + @user.login_token
end
 
Then(/^I should see "(.*?)"$/) do |expectedText|
    # visit('/dashboard')
    puts page.has_content?(@role)
end