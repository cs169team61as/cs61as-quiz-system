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
  Then I want to see this short answer question question with these options in the quiz
  

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


Scenario: I want to see a multiple choice question when I am taking the quiz
  Given a quiz with a multiple choice question "How many legs does a cat have?" and answer "4" exists:
  | 0 |
  | 2 |
  | 4 |
  Given I am taking this quiz
  Then I want to see this multiple choice question with these options in the quiz


Scenario: I want to see a true/false question when I am taking the quiz
  Given a quiz with a true/false question "Can cats fly?" and answer "false" exists
  Given I am taking this quiz
  Then I want to see this true/false question with these options in the quiz


Scenario: I want to see a schema code question when I am taking the quiz
  Given a quiz with a scheme code question "Please write a code that says 'Hello World!" and answer "Hello World!" exists
  Given I am taking this quiz
  Then I want to see this schema question with these options in the quiz