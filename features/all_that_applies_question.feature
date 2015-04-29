Feature: All that applies question

  As a Devleoper,
  I want to know immediately if things break when I modify my class.
  So I included the list of places that I know broke before when I
  modified AllThatAppliesQuestion class in the past.


Background:
  Given I am logged in as a staff user
  And the "cat" all that applies question "What coat colors are typical in cats" exists in "Lesson 1" bank:
  | option | correct |
  | White  | correct |
  | Green  | wrong   |
  | Black  | correct |
  | Purple | wrong   |
  And a test containing cat question exists and the question is worth 10 points
  And a submission of cat test exists where the chosen options are:
  | option | correct |
  | White  | correct |
  | Green  | correct |
  | Black  | correct |
  | Purple | wrong   |


Scenario: I want to be able to edit the rubric
  Given I am on the Questions page
  When I edit the cat question
  And I fill in "Rubric" with "Blah blah blah!!1"
  And I click "Update"
  Then I should see "Blah blah blah!!1" on the view page for the cat question in "Rubric"


Scenario: I want to be able to edit the question text
  Given I am on the Questions page
  When I edit the cat question
  And I fill in "Question" with "What chromatic patterns of felines are statistically prevalent?"
  And I click "Update"
  Then I should see "What chromatic patterns of felines are statistically prevalent?" on the view page for the cat question in "Content"


Scenario: I want to be able to edit the options text
  Given I am on the Questions page
  When I edit the cat question
  And the pre-existing options should be:
  | White  | correct |
  | Green  | wrong   |
  | Black  | correct |
  | Purple | wrong   |
  And I fill in "Option 5" with "Yellow" 
  And check "Option 5" as correct
  And I click "Update"
  Then I should see "Yellow" on the view page for the cat question in "Solution"
  And the cat question should recognize "Yellow" as a "correct" answer


Scenario: I want to be able to edit the options correctness
  Given I am on the Questions page
  And the cat question should recognize "Purple" as a "wrong" answer
  When I edit the cat question
  And check "Option 4" as correct
  And I click "Update"
  Then I should see "Purple" on the view page for the cat question in "Solution"
  And the cat question should recognize "Purple" as a "correct" answer


Scenario: I want to be able to create a new question from the questions page
  Given I am on the Questions page
  When I click "New All That Applies Question!"
  And I select "2" from "Lesson"
  And I fill in "Question" with "Which numbers are odd?"
  And I fill in "Rubric" with "(no rubric)"
  And I fill in Options as:
  |   1      |	 correct	|
  |   2	     |	 wrong		|
  |   3	     |	 correct	|
  |   4	     |	 wrong		|
  And I click "Create"
  Then I should see "Which numbers are odd?" on the bank page for "Lesson 2"


Scenario: I want to be able to create a new question from the quiz
  And I am on the Staff Dashboard
  And I create a new quiz
  And I click "New All That Applies Question!"
  And I fill in "Question" with "Which of these words stand for colors?"
  And I fill in "Rubric" with "(no rubric)"
  And I fill in Options as:
  |   red      |	 correct	|
  |   green	   |	 correct	|
  |   box	     |	 wrong		|
  |   orange	 |	 correct	|
  And I click "Create"
  Then I should see "Editing Quiz"
  And I should see "Which of these words stand for colors?"


Scenario: Solution correctly displays when I grade this question
  Given I am grading the cat question
  Then "Solution" should contain "White, Black" 
  And "Solution" should not contain "Green, Purple"


Scenario: Autograder grades this question correctly
  Given I am grading the cat question
  Then "Comments" should contain "White, Green, Black"
  And Grade should be "5.0"

