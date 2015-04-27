Feature: Number of quizzes to be graded

  As a TA,
  I want what would scheme output and True/False questions to be auto-graded
  so that it takes less time for the readers to grade.

Background:
  Given I am logged in as a staff user

Scenario: I should see the autograder result from each quiz
  Given that I have a quiz to grade for cs61as-aa
  When I follow a quiz to grade
  Then I should see partial score for autograded questions
