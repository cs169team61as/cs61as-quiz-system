Feature: Ability to Autograde supported question types

  As a TA or Reader,
  I want to be able to autograde questions
  So that I can easily grade quizzes

Background:
  Given I am logged in as a staff user

  And the follwing all that applies question with id "33" exists in lesson "2"
  | option  | correct |
  | 2       | correct |
  | 3       | wrong   |
  | 4       | wrong   |
  | 2/1     | correct |
  And a test with question id "33" exists
  And a quiz submission with id "21" with only question id "33" exists with options
  | option  | correct |
  | 2       | correct |
  | 3       | correct |
  | 4       | correct |
  | 2/1     | wrong   |

    And a quiz submission with id "22" with only question id "33" exists with options
  | option  | correct |
  | 2       | correct |
  | 3       | correct |
  | 4       | correct |
  | 2/1     | correct |


Scenario: I should see the autograder button
  Given that I am grading the quiz with id "21"
  Then I should see "Autograde!"

Scenario: The autograde button should update the scores
  Given that I am grading the quiz with id "21"
  Then I should see "Total: 0.0/10"
  When I click "Autograde!"
  Then I should see "Total: 0.0/10"

Scenario: The autograde button should update the scores
  Given that I am grading the quiz with id "22"
  Then I should see "Total: 0.0/10"
  When I click "Autograde!"
  Then I should see "Total: 10.0/10"

