Feature: Instructor Listing
  As an admin
  In order to be able to make people instructors
  I want to be able to use an interface that lets me add and remove instructors

Scenario: Navigate to Instructor Listing page as an Instructor
    Given that I am an instructor
    When I login as "test_i@x.x"
    When I am on the "Dashboard" page 
    Then I should not see "Instructor Listing"
    
Scenario: Navigate to Instructor Listing page as a Student
    Given that I am an instructor
    When I login as "test_s@x.x"
    When I am on the "Dashboard" page 
    Then I should not see "Instructor Listing"
    
Scenario: Navigate to Instructor Listing page as an Admin
    Given that I am an admin
    When I login as "test_a@x.x"
    When I am on the "Dashboard" page 
    Then I should see "Instructor Listing"
    And I click the link "Instructor Listing"
    Then I should see "Instructors"
    
Scenario: Accidentally make someone an instructor and remove them
    Given that I am an admin
    When I login as "test_a@x.x"
    When I am on the "Dashboard" page 
    Then I should see "Instructor Listing"
    And I click the link "Instructor Listing"
    And I make sure "test_s@x.x" is a "student"
    When I input "test_s@x.x" to "search_query"
    And I click "Add"
    Then I should see "Added test_s@x.x"
    And I click the link "x" in "td" with "test_s@x.x" as an id
    Then I should see "Removed test_s@x.x"