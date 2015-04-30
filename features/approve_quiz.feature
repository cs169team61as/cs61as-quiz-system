Feature: approving a quiz

  As a TA for CS61AS
  So that students can pass the class
  I want to approve student quizzes

Background:
  Given the web site is set up
  Given cs61as-ta is logged in
  
Scenario: I don't have any quizzes to approve
  Given I am logged in as a staff user
  And I am on the Requests page
  Then I should see "Quiz Requests"
  And I should see "You don't have any quiz requests!"

Scenario: approving a quiz
  When cs61as-st requests a quiz for lesson 2
  And I am on the Staff Dashboard
  And I am on the Requests page
  Then I should see "Quiz Requests"
  And I should see "cs61as-st"
  Then I press "Approve"
  Then I should see "Quiz Requests"
  And I should see "You don't have any quiz requests!"

Scenario: many quizzes
  When cs61as-st and cs61as-bb request quizzes for lesson 2
  And I am on the Staff Dashboard
  And I am on the Requests page
  Then I should see "Quiz Requests"
  And I should see "cs61as-st"
  And I should see "cs61as-bb"
  Then I press "Approve" for "cs61as-st"
  And I should see "cs61as-bb"
  And I should not see "cs61as-st"