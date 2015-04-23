Feature: Different question types for the quizzes

  As a Student,
  I want different question types to display correctly on the quiz taking page
  so that I can take a quiz made of different types of questions.
  (Actually maybe it's benificial to separate different question types
  into different feature files.)


Scenario: I want to see a simple choice question when I am taking the test
  Given I am logged in as a student
  Given a test containing this simple choice question exists:
  | How many legs does a cat have? ((4)) |
  | 0 |
  | 2 |
  | 4 |
  Given I am taking this test
  Then I want to see this question with these options in the quiz


Scenario: I want to see a true/false question when I am taking the test
  Given I am logged in as a student
  Given a test containing this true/false question exists:
  | Can cats fly? ((false)) |
  Given I am taking this test
  Then I want to see this question with these options in the quiz


Scenario: I want to see a short answer question when I am taking the test
  Given I am logged in as a student
  Given a test containing this short answer question exists:
  | What is the binomal name of the domestic cat specie? ((Felis catus)) |
  Given I am taking this test
  Then I want to see this question with these options in the quiz
  

Scenario: I want to see a multiple choice question when I am taking the test
  Given I am logged in as a student
  Given a test containing this multiple choice question exists:
  | What coat colors are typical in cats? ((White, Black)) |
  | White |
  | Green |
  | Black |
  | Purple |
  Given I am taking this test
  Then I want to see this question with these options in the quiz


Scenario: I want to see a scheme code question when I am taking the test
  Given I am logged in as a student
  Given a test containing this scheme code question exists:
  | Please write a code that says "Hello World!" ((Hello World!)) |
  Given I am taking this test
  Then I want to see this question with these options in the quiz