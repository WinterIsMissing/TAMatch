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

Then(/^I should( not)? see "(.*?)"$/) do |not_visible, text|
    begin
        expect(page.has_content?(text)).to eq !not_visible
    rescue
        raise "Did you seed the test db? 'rails db:migrate RAILS_ENV=test'"
    end
end

And(/^I see a student email$/) do
    button = find('tr:nth-child(2) input[value="2"]')
    @email = button[:email]
end

When(/^I login through google$/) do
    visit '/auth/google'
end

When(/^I am on the "(.*?)" page$/) do |targ_page|
    case targ_page
    when 'Dashboard'
        visit dashboard_path
    when 'Register'
        visit register_path
    when 'TA Application'
        visit new_applicant_path
    when 'Instructor Preferences'
        visit prof_ranking_index_path
    when 'Instructor Listing'
        visit instructors_index_path
    end
end

And(/^I select "(.*?)" from "(.*?)"$/) do |item, form|
    select(item, :from => form)
end

And(/^I check "(.*?)"$/) do |item|
    check(item)
end

When(/^I input "(.*?)" to "(.*?)"$/) do |text, field|
    if text == '@email'
        text = @email
    end
    fill_in(field, :with => text)
end

And(/^I click "(.*?)"$/) do |button|
    click_button button
end

And(/^I click the link "(.*?)"$/) do |link_text|
    click_link link_text
end

And(/^I click the link "(.*?)" in "(.*?)" with "(.*?)" as an id$/) do |link_text, outer_tag, id|
    find(outer_tag, id: id).click_link(link_text)
end

Then(/^I can submit my information$/) do
    click_button "submit"
end

And(/^I want to register with "(.*?)" and "(.*?)"$/) do |email, username|
    user = User.find_by(email: email)
    if user
        user.destroy
    end
    user = User.find_by(username: username)
    if user
        user.destroy
    end
end

And(/^I make sure "(.*?)" is a "(.*?)"$/) do |email, auth_level|
    user = User.find_by(email: email)
    if user
        user.auth_level = auth_level
        user.save!
    end
end

And(/^I look for the "(.*?)" element$/) do |text|
    if text == '@email'
        text = @email
    end
    @element = find('tr:nth-child(2) input[value="2"]')
end

Then(/^"(.*?)" should be checked$/) do |element|
    if element == "@element"
        element = @element
    end
    expect(element.checked?).to eq true
end