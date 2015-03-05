Feature: autograder for wwso, t/f and multiple choice questions

	As a TA or a reader,
	So that I can easily grade wwso, t/f and multiple choice questions
	I want to be able to automatically grade wwso, t/f and multiple choice questions

Senario: Should have autograde button

	Given that I am on

Scenario: Autograde quiz

	Given that I am on the staff dashboard
	And I press "Grading"
	And I press "cs61as-aa:Quiz 1a1"
	I should see "Autograde"
	When I press "Autograde"
	I should see "Autograder complete"
	And I should see "0.0"
