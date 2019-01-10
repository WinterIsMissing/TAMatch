Feature: Matchmaker view
  As an admin
  In order to know what the matchmaker outputs
  I want to see all of the courses' statuses and their instructor and applicants.

Scenario: Navigate to Matchmaker page as an Instructor
    Given that I am an instructor
    When I login as "test_i@x.x"
    When I am on the "Dashboard" page 
    Then I should not see "Matchmaker"
    
Scenario: Navigate to Matchmaker page as a Student
    Given that I am an instructor
    When I login as "test_s@x.x"
    When I am on the "Dashboard" page 
    Then I should not see "Matchmaker"
    
Scenario: Navigate to Matchmaker page as an Admin
    Given that I am an admin
    When I login as "test_a@x.x"
    When I am on the "Dashboard" page 
    Then I should see "Matchmaker"
    And I input "CSCE 313" to "search_query"
    And I click the link "Matchmaker"
    Then I should see "Matchmaker"