Feature: Auto refresh when quiz is approved

  As a student
  So that I know my quiz is approved to be taken
  My page is refreshed automatically after TA's approval.


Scenario: Auto refresh the page
  Given I am on the quiz approval page
  And I should see "Your request is not approved yet!"
  When I approve a quiz it is approved
  Then I should see the button "Begin quiz!"