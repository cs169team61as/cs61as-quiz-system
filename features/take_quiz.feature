Feature: taking a quiz
 
  As a student
  So that I can pass the class
  I want to take a quiz

Background: ???

Scenario: Request a quiz
  Given I am on the Student Dashboard  
  When I select 0-1 - Intro
  And I press "Request quiz!"
  Then I should be on the quiz approval page
  And I should see "Please wait for your quiz to be approved"

Scenario: Taking a quiz
  Given I am on the quiz approval page
  I should see "your quiz has been approved"
  Then I press "Take quiz"
  Then I press "Begin quiz"
  Then I should be on the quiz page
  And I should see "Question 1"
  And I should see "You have (.d) minutes(s) (.d) second(s) remaining"
  Then I press "Submit"
  Then I should be on the Student Dashboard