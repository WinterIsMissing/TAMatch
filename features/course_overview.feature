Feature: Course Overview
  As an admin
  In order to know how a course is doing overall
  I want to see the course's listed instructors and their assigned students.

Scenario: Navigate to Course Overview page as an Instructor
    Given that I am an instructor
    When I login as "test_i@x.x"
    When I am on the "Dashboard" page 
    Then I should not see "Course Overview"
    
Scenario: Navigate to Course Overview page as a Student
    Given that I am an instructor
    When I login as "test_s@x.x"
    When I am on the "Dashboard" page 
    Then I should not see "Course Overview"
    
Scenario: Navigate to Course Overview page as an Admin
    Given that I am an admin
    When I login as "test_a@x.x"
    When I am on the "Dashboard" page 
    Then I should see "Course Overview"
    And I input "CSCE 313" to "search_query"
    And I click "Search"
    Then I should see "CSCE 313"