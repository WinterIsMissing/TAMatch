Feature: TA Application
  As a user that is a TA
  In order to be able to apply for TA positions.
  I want to be able to specify details about my preferences.

Scenario: Input fields for the TA Application 
  Given that I am a student
  When I login as "test_s@x.x"
  When I am on the "TA Application" page 
  And I select "MS Thesis" from "degreeProgram"
  And I check "gCheck"
  Then I can submit my information
  
Scenario: Navigate to the TA Application page as a student
  Given that I am a student
  When I login as "test_s@x.x"
  When I am on the "Dashboard" page
  Then I should see "Create Application"
  And I click the link "Create Application"
  Then I should see "TA Application"

Scenario: Navigate to the TA Application page as an instructor
  Given that I am an instructor
  When I login as "test_i@x.x"
  When I am on the "Dashboard" page
  Then I should not see "Create Application"

Scenario: Navigate to the TA Application page as an admin
  Given that I am an admin
  When I login as "test_a@x.x"
  When I am on the "Dashboard" page
  Then I should not see "Create Application"
