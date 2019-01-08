Feature: Register an Account
  As a user
  In order to be able to use TAnder services
  I want to be able to register an account.

Scenario: I am a student wanting to register an account.
  Given that I am a student
  When I input my information
  Then I should see "We have sent you the link"
