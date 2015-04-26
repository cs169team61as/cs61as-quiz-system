Feature: Multiple choice question

  As a Devleoper,
  I want to know immediately if things break when I modify my class.
  So I included the list of places that I know broke before when I
  modified MultipleChoiceQuestion class in the past.


Background:
  Given I am logged in as a staff user
  And this multiple choice question exists in "Lesson 1" bank
  | What coat colors are typical in cats? | Correctness |
  | White  | correct |
  | Green  | wrong   |
  | Black  | correct |
  | Purple | wrong   |
  And a test containing this question exists and the question is worth 10 points
  And a submission of this test exists where the chosen options are:
  | White |
  | Green |
  | Black |

# Then I should see this text on the bank page for "Lesson 1" 
#    is the same as 
# Then I sould see "Updated Question!"
# And when I click "Lesson 1"
# Then I should see that text

Scenario: I want to be able to edit the rubric
  Given I am on the Questions page
  When I edit my question
  And I fill in "Rubric" with "Blah blah blah!!1"
  And I click "Update""
  Then I should see this text on the bank page for "Lesson 1" 


Scenario: I want to be able to edit the question text
  Given I am on the Questions page
  When I edit my question
  And I fill in "Question" with "What chromatic patterns of felines are statistically prevalent?"
  And I click "Update"
  Then I should see this text on the bank page for "Lesson 1" in "Content" column


Scenario: I want to be able to edit the options text
  Given I am on the Questions page
  When I edit my question
  And the pre-existing options should be:
  | White  | correct |
  | Green  | wrong   |
  | Black  | correct |
  | Purple | wrong   |
  And I fill in "Option 5" with "Yellow"
  And I click "Update"
  And I edit my question
  Then I should see "Yellow" on the bank page for "Lesson 1"


Scenario: I want to be able to edit the options correctness
  Given I am on the Questions page
  When I edit my question
  And I fill in "Option 5" with "Yellow" and check it as correct
  And I click "Update"
  Then I should see this text on the bank page for "Lesson 1" in "Solution" column


Scenario: I want to be able to create a new question from the questions page
  Given I am on the Questions page
  When I click "New Multiple Choice Question!"
  And I fill in "Lesson" with "2"
  And I fill "Question" with "Which numbers are odd?"
  And I fill "Rubric" with "(no rubric)"
  And I fill in Options as:
  |   1      |	 correct	|
  |   2	     |	 wrong		|
  |   3	     |	 correct	|
  |   4	     |	 wrong		|
  And I click "Create"
  Then I should see "Created new Question!"
  Then I should see "Which numbers are odd?" on the bank page for "Lesson 2" in "Content"


Scenario: I want to be able to create a new question from the quiz
  Given I am on the Dashboard
  And I click "Create a New Quiz!"
  And I click "New Multiple Choice Question!"
  And I fill "Question" with "Which of these words stand for colors?"
  And I fill "Rubric" with "(no rubric)"
  And I fill in Options as:
  |   red      |	 correct	|
  |   green	   |	 correct	|
  |   box	     |	 wrong		|
  |   orange	 |	 correct	|
  And I click "Create"
  Then I should see "Editing Quiz"
  And I should see "Which of these words stand for colors?"


Scenario: Solution correctly displays when I grade this question
  Given I am grading this question
  Then I should see "White" within "Solution"
  And I should see "Black" within "Solution"
  But I should not see "Green" within "Solution"
  And I should not see "Purple" within "Solution"


Scenario: Autograder grades this question correctly
  Given I am grading this question
  Then I should see "5.0" within "Grade"
  And I should see "White" within "Comments"
  And I should see "Green" within "Comments"
  And I should see "Black" within "Comments"
