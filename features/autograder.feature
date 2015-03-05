Feature: Number of quizzes to be graded

  As a TA,
  I want what would scheme output and True/False questions to be auto-graded
  so that it takes less time for the readers to grade.

Scenario: I should not see T/F or What would scheme output questions in grading
  Given that I am on the staff dashboard
  When I follow "Grading"
  And I press a quiz to grade
  I should not see True/False questions
  And I should not see What would scheme output question
  I should only see ungraded questions

Scenario: I should see the autograder result from each quiz
  Given that I have a quiz to grade for cs61as-aa
  When I follow a quiz to grade
  I should see partial score for autograded questions
  