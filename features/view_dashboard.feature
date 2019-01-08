Feature: Dashboard View
  As a user
  In order to get a gist of my account status
  I want to see a dashboard upon login.

Scenario: I am a student.
  Given that I am a student
  When I login as "test_student@x.x"
  Then I should see "Student"
  
@wip
Scenario: I am an admin.
  Given that I am an admin
  When I login as "test_admin@x.x"
  Then I should see "Admin"
 
@wip
Scenario: I am an instructor.
  Given that I am an instructor
  When I login as "test_instructor@x.x"
  Then I should see "Instructor"