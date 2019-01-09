Feature: Register an Account
  As a user
  In order to be able to use TAnder services
  I want to be able to register an account.

Scenario: I am a user wanting to register an account.
  Given I am on the "Register" page
  When I input "Tes Ter" to "user_fullname"
  When I input "tester" to "user_username"
  When I input "tester0952@tamu.edu" to "user_email"
  And I want to register with "tester0952@tamu.edu" and "tester"
  And I click "Register"
  Then I should see "We have sent you the link"
