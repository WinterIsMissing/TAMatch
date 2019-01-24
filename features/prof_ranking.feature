Feature: Rank TAs
  As an instructor
  In order to have a chance of getting TAs that I like
  I want to be able to specify my preferences of TAs for my positions

Scenario: Navigate to Instructor Preferences page as an Instructor
    Given that I am an instructor
    When I login as "test_i@x.x"
    When I am on the "Dashboard" page 
    Then I should see "Rank Applications"
    And I click the link "Rank Applications"
    Then I should see "Instructor Preferences"
    
Scenario: Navigate to Instructor Preferences page as a Student
    Given that I am an instructor
    When I login as "test_s@x.x"
    When I am on the "Dashboard" page 
    Then I should not see "Rank Applications"
    
Scenario: Navigate to Instructor Preferences page as an Admin
    Given that I am an admin
    When I login as "test_a@x.x"
    When I am on the "Dashboard" page 
    Then I should not see "Rank Applications"

Scenario: Navigate to Instructor Preferences page as an Instructor
    Given that I am an instructor
    When I login as "test_i@x.x"
    When I am on the "Instructor Preferences" page
    And I see a student email
    And I input "2" to "preference_rating"
    And I input "@email" to "preference_email"
    And I click "Submit"
    When I am on the "Instructor Preferences" page
    And I look for the "@email" element
    Then "@element" should be checked
    