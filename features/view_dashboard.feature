Feature: Dashboard View
  As a user
  In order to get a gist of my account status
  I want to see a dashboard upon login.

Scenario: I am a student wanting to view my dashboard.
  Given that I am a student
  When I login as "test_s@x.x"
  Then I should see "Student"

Scenario: I am an admin wanting to view my dashboard.
  Given that I am an admin
  When I login as "test_a@x.x"
  Then I should see "Admin"

Scenario: I am an instructor wanting to view my dashboard.
  Given that I am an instructor
  When I login as "test_i@x.x"
  Then I should see "Instructor"