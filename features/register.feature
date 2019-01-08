Feature: Register an Account
  As a user
  In order to be able to use TAnder services
  I want to be able to register an account.

Scenario: I am a student wanting to register an account.
  Given that I am a student
  When I am on the "Register" page
  When I input "Tes Ter" to "user_fullname"
  When I input "tester" to "user_username"
  When I input "tester@testing.x" to "user_email"
  And I want to register with "tester@testing.x"
  And I click "Register"
  Then I should see "We have sent you the link"
