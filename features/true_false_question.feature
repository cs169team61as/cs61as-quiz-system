Feature: True/False question
	As a staff, 
	I want to create true false question
	So that I can include the new question type in quizzes without breaking.
	
Background:
  Given I am logged in as a staff user
  And true false question "1+1 == 2" exists
  And a test containing "cat" question exists and the question is worth 10 points
  And a submission of cat test exists where the chosen option is "True"
  
Scenario: I want to create a new true false question from the questions page
  Given I am on the Questions page
  When I click "New True False Question!"
  And I select "1" from "Lesson"
  And I fill in "Question" with "Is the sky blue?"
  And I select "False" from "true_false_question_my_solution"
  And I click "Create"
  Then I should see "Is the sky blue?" on the bank page for "Lesson 1"
  
Scenario: I want to edit a true false question's solution
  Given I am on the Questions page
  When I click "Lesson 2"
  And I edit the "cat" question
  And I select "True" from "true_false_question_my_solution"
  And I click "Update"
  Then I should see "True" on the bank page for "Lesson 2"
  
Scenario: I want to edit a true false question's question text
  Given I am on the Questions page
  When I click "Lesson 2"
  And I edit the "cat" question
  And I fill in "Question" with "Is the weather nice?"
  And I click "Update"
  Then I should see "Is the weather nice" on the bank page for "Lesson 2"
  
Scenario: Solution correctly displays when I grade this question
  Given I am grading the "cat" question
  Then "Solution" should contain "True"
  And "Solution" should not contain "False"
  
Scenario: Autograder grades this question correctly
  Given I am grading the "cat" question
  And Grade should be "0.0" 
  
  