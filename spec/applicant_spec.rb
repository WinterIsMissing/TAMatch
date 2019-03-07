require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'
require 'time'

RSpec.describe "Application", :type => :feature do
  it 'create an application successfully' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Student")
    expect(page).to have_content("Application")
    visit new_applicant_path
    expect(page).to have_content("Application")
    find("#years").select("1")
    check("taCheck")
    fill_in('application_payload', :with=>'{
        "advisor":"hello", "years":"2", "degree_program":"msThesis", "isTA":true, "isGrader":false, "isSG":false, "preferences":["121", "181"], "indifferent":["110", "111", "206", "221", "310", "312", "313", "314", "315", "410", "411", "420", "431", "433", "436", "438", "440", "441", "443", "445", "451", "462", "463", "465", "470", "481", "482", "483", "485", "489", "491"], "antipref":["222", "291"]}')
    find('input[name="commit"]').click
    applicant = Applicant.find_by("email": "test_s@x.x")
    expect(applicant.nil?).to be false
  end
  it 'create and edit an application successfully' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    visit new_applicant_path
    find("#years").select("2")
    check("taCheck")
    fill_in('application_payload', :with=>'{
        "advisor":"kenobi", "years":"2", "degree_program":"msThesis", "isTA":true, "isGrader":false, "isSG":false, "preferences":["121", "181"], "indifferent":["110", "111", "206", "221", "310", "312", "313", "314", "315", "410", "411", "420", "431", "433", "436", "438", "440", "441", "443", "445", "451", "462", "463", "465", "470", "481", "482", "483", "485", "489", "491"], "antipref":["222", "291"]}')
    find('input[name="commit"]').click
    applicant = Applicant.find_by("email": "test_s@x.x")
    visit edit_applicant_path(:id => applicant)
    fill_in('application_payload', :with=>'{
        "advisor":"kenobi", "years":"2", "degree_program":"msThesis", "isTA":true, "isGrader":false, "isSG":false, "preferences":["121", "181","110","431","420"], "indifferent":["111", "206", "221", "310", "312", "313", "314", "315", "410", "411", "433", "436", "438", "440", "441", "443", "445", "451", "462", "463", "465", "470", "481", "482", "483", "485", "489", "491"], "antipref":["222", "291"]}')
    find('input[name="commit"]').click
    applicant = Applicant.find_by("email": "test_s@x.x")
    expect(applicant.nil?).to be false
  end
  it 'create and destroy an application successfully' do 
    email = "test_s@x.x"
    @user = User.find_by(email: email)
    token = @user.generate_login_token
    visit '/auth?' + token
    expect(page).to have_content("Student")
    expect(page).to have_content("Application")
    visit new_applicant_path
    expect(page).to have_content("Application")
    find("#years").select("1")
    check("taCheck")
    fill_in('application_payload', :with=>'{
        "advisor":"hello", "years":"2", "degree_program":"msThesis", "isTA":true, "isGrader":false, "isSG":false, "preferences":["121", "181"], "indifferent":["110", "111", "206", "221", "310", "312", "313", "314", "315", "410", "411", "420", "431", "433", "436", "438", "440", "441", "443", "445", "451", "462", "463", "465", "470", "481", "482", "483", "485", "489", "491"], "antipref":["222", "291"]}')
    find('input[name="commit"]').click
    applicant = Applicant.find_by("email": "test_s@x.x")
    visit applicant_path(:id => applicant)
    expect(applicant.nil?).to be false
    visit view_applications_path
    click_link "Delete Application"
    applicant = Applicant.find_by("email": "test_s@x.x")
    expect(applicant.nil?).to be true
  end
end