#features/step_definitions/TAAppSteps.rb
require 'uri'
require 'cgi'


Given(/^that I am an? (.*?)$/) do |role|
    @role = role
end

When(/^I input my information "(.*?)"$/) do |myInfo|
    visit '/TAApp'
    fill_in 'firstName', :with => myFirstName
    fill_in 'lastName', :with => myLastName
    fill_in 'email', :with => email
    find('input[name="submit"]').click

    puts firstName
    puts lastName
    puts email
end
