Feature: Multiple choice question


  In order to create questions with one answer out of multiple
  As a TA
  I want to be able to create edit and add multiple choice questions to a quiz


 Background:
   Given I am logged in as a staff user
   And the "dog" multiple choice question "How many legs do dogs nurmally have?" exists in "Lesson 1" bank:
   | option | correct |
   | One    | wrong   |
   | Two    | wrong   |
   | Three  | wrong   |
   | Four   | correct |
   | Five   | wrong   |
   | Six    | wrong   |
   And a test containing "dog" question exists and the question is worth 10 points



 Scenario: Rubric is editable
   Given I am on the Questions page
   When I edit the "dog" question
   And I fill in "Rubric" with "Blah blah blah!!1"
   And I click "Update"
   Then I should see "Blah blah blah!!1" on the view page for the "dog" question in "Rubric"


 Scenario: I want to be able to edit the question text
   Given I am on the Questions page
   When I edit the "dog" question
   And I fill in "Question" with "What number of appendages does an average canine use for locomotion?"
   And I click "Update"
   Then I should see "What number of appendages does an average canine use for locomotion?" on the view page for the "dog" question in "Content"


 Scenario: I want to be able to edit the options text
   Given I am on the Questions page
   When I edit the "dog" question
   And the pre-existing options of my multiple choice question should be:
   | One    | wrong   |
   | Two    | wrong   |
   | Three  | wrong   |
   | Four   | correct |
   | Five   | wrong   |
   | Six    | wrong   |
   And I fill in "Option 7" with "Zero"
   And choose "Option 7" as correct
   And I click "Update"
   Then I should see "Zero" on the view page for the "dog" question in "Solution"
   And the "dog" question should recognize "Zero" as a "correct" answer


 Scenario: I want to be able to edit the options correctness
   Given I am on the Questions page
   And the "dog" question should recognize "One" as a "wrong" answer
   When I edit the "dog" question
   And choose "Option 1" as correct
   And I click "Update"
   Then I should see "One" on the view page for the "dog" question in "Solution"
   And the "dog" question should recognize "One" as a "correct" answer


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
   And I fill in "Question" with "Where do the squirrels live??"
   And I fill in "Rubric" with "(no rubric)"
   And I fill in Options of my multiple choice question as:
   |   On GitHub        |   wrong      |
   |   On Mars          |   wrong      |
   |   In the ocean     |   wrong      |
   |   On the trees     |   correct    |
   |   Under carpet     |   wrong      |
   And I click "Create"
   Then I should see "Editing Quiz"
   And I should see "Where do the squirrels live??"


 Scenario: Solution correctly displays when I grade this question
   Given a submission of the "dog" test exists where the student selected "Four"
   And I am grading the "dog" question
   Then "Solution" should contain "Four"
   And "Solution" should not contain "One, Two, Three, Five, Six"


 Scenario: Autograder gives full credit for the right answer
   Given a submission of the "dog" test exists where the student selected "Four"
   And I am grading the "dog" question
   Then the Grade should be "10.0"


 Scenario: Autograder gives no credit for the wrong answer
   Given a submission of the "dog" test exists where the student selected "Three"
   And I am grading the "dog" question
   Then the Grade should be "0.0"

