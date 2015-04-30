Feature: Multiple choice question


  In order to create questions with one answer out of multiple
  As a TA
  I want to be able to create edit and add multiple choice questions to a quiz


 Background:
   Given I am logged in as a staff user
   And the "cat" multiple choice question "How many legs do cats nurmally have?" exists in "Lesson 1" bank:
   | option | correct |
   | One    | wrong   |
   | Two    | wrong   |
   | Three  | wrong   |
   | Four   | correct |
   | Five   | wrong   |
   | Six    | wrong   |
   And a test containing "cat" question exists and the question is worth 10 points



 Scenario: Rubric is editable
   Given I am on the Questions page
   When I edit the "cat" question
   And I fill in "Rubric" with "Blah blah blah!!1"
   And I click "Update"
   Then I should see "Blah blah blah!!1" on the view page for the "cat" question in "Rubric"


 Scenario: I want to be able to edit the question text
   Given I am on the Questions page
   When I edit the "cat" question
   And I fill in "Question" with "What number of appendages does an average feline use for locomotion?"
   And I click "Update"
   Then I should see "What number of appendages does an average feline use for locomotion?" on the view page for the "cat" question in "Content"


 Scenario: I want to be able to edit the options text
   Given I am on the Questions page
   When I edit the "cat" question
   And the pre-existing options of my multiple choice question should be:
   | One    | wrong   |
   | Two    | wrong   |
   | Three  | wrong   |
   | Four   | correct |
   | Five   | wrong   |
   | Six    | wrong   |
   And I fill in "Option 7" with "Zero"
   And check "Option 7" as correct
   And I click "Update"
   Then I should see "Zero" on the view page for the "cat" question in "Solution"
   And the "cat" question should recognize "Zero" as a "correct" answer


 Scenario: I want to be able to edit the options correctness
   Given I am on the Questions page
   And the "cat" question should recognize "Purple" as a "wrong" answer
   When I edit the "cat" question
   And check "Option 1" as correct
   And I click "Update"
   Then I should see "One" on the view page for the "cat" question in "Solution"
   And the "cat" question should recognize "One" as a "correct" answer


 Scenario: I want to be able to create a new question from the questions page
   Given I am on the Questions page
   When I click "New Multiple Choice Question!"
   And I select "2" from "Lesson"
   And I fill in "Question" with "Which color does grass have?"
   And I fill in "Rubric" with "(no rubric)"
   And I fill in Options of my multiple choice question as:
   |   White      |   correct    |
   |   Green      |   wrong      |
   |   Black      |   correct    |
   |   Yellow     |   wrong      |
   And I click "Create"
   Then I should see "Which color does grass have?" on the bank page for "Lesson 2"


 Scenario: I want to be able to create a new question from the quiz
   And I am on the Staff Dashboard
   And I create a new quiz
   And I click "New Multiple Choice Question!"
   And I fill in "Question" with "Where do squirrels live??"
   And I fill in "Rubric" with "(no rubric)"
   And I fill in Options of my multiple choice question as:
   |   On GitHub        |   wrong      |
   |   On Mars          |   wrong      |
   |   In the ocean     |   wrong      |
   |   On the trees     |   correct    |
   |   Under carpet     |   wrong      |
   And I click "Create"
   Then I should see "Editing Quiz"
   And I should see "Which of these words stand for colors?"


 Scenario: Solution correctly displays when I grade this question
   Given I am grading the "cat" question
   Then "Solution" should contain "Four"
   And "Solution" should not contain "One, Two, Three, Five, Six"


 Scenario: Autograder gives full credit for the right answer
   Given a submission of the "cat" test exists where the student selected "3"
   And I am grading the "cat" question
   Then the Grade should be "10.0"


 Scenario: Autograder gives no credit for the wrong answer
   Given a submission of the "cat" test exists where the student selected "2"
   And I am grading the "cat" question
   Then the Grade should be "0.0"

