Feature: Different question types for the quizzes

  As a Student,
  I want different question types to display correctly on the quiz taking page
  so that I can take a quiz made of different types of questions.
  (Actually maybe it's benificial to separate different question types
  into different feature files.)

Background:
  Given I am logged in as a student

Scenario: I want to see a short answer question when I am taking the quiz
  Given a quiz with a short answer question "What is the binomal name of the domestic cat specie?" and answer "Felis catus" exists
  Given I am taking this quiz
  Then I want to see this short answer question with these options in the quiz
  

Scenario: I want to see an all that applies question when I am taking the quiz
  Given a quiz with an all that applies question "Which of these numbers end with 1?" exists:
  | option | correct |
  |   131  | correct |
  |   332  | wrong   |
  |   231  | correct |
  |   256  | wrong   |
  |   846  | wrong   |
  |   634  | wrong   |
  Given I am taking this quiz
  Then I want to see this all that applies question with these options in the quiz

Scenario: I want to ensure that all that applies question form submits
  Given a quiz with an all that applies question "Which of these numbers end with 1?" exists:
  | option | correct |
  |   131  | correct |
  |   332  | wrong   |
  |   231  | correct |
  |   256  | wrong   |
  |   846  | wrong   |
  |   634  | wrong   |
  Given I am taking this quiz
  And I check "quiz_new_submissions_attributes_0_content_correct_0"
  And I check "honesty_statement"
  And I press "Submit"
  And the submission from this quiz with a single question will score "5.0"



Scenario: I want to see a multiple choice question when I am taking the quiz
  Given the "this" multiple choice question "How many legs does a cat have?" exists in "Lesson 1" bank:
  | option  | correct   |
  | 0       | wrong     |
  | 2       | wrong     |
  | 4       | correct   |
  Given I am taking this quiz
  Then I want to see this multiple choice question with these options in the quiz

Scenario: I want to make sure form submits properly for multiple choice
  Given the "this" multiple choice question "How many legs does a cat have?" exists in "Lesson 1" bank:
  | option  | correct   |
  | 0       | wrong     |
  | 2       | wrong     |
  | 4       | correct   |
  Given I am taking this quiz
  #Then show me the page
  And I choose "quiz_new_submissions_attributes_0_content_correct_2_2"
  And I check "honesty_statement"
  And I press "Submit"
  And the submission from this quiz with a single question will score "10.0"




Scenario: I want to see a true/false question when I am taking the quiz
  Given a quiz with a true/false question "Can cats fly?" and answer "False" exists
  Given I am taking this quiz
  Then I want to see this true/false question with these options in the quiz

