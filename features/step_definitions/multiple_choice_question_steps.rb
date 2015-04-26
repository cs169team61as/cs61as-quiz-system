Given(/^a multiple choice question "(.*?)" exists in "Lesson (\d+)" bank:$/) do |content, lesson, table|
  choices = Hash.new
  table.hashes.each do |row|
    choices[row[:option]] = row[:correcntess] == "correct"
  end
  q = MultipleChoiceQuestion.build content: content, lesson: lesson, 
                                   difficulty: "Easy", choices: choices
  q.save!
  @cat_question = q
end

Given(/^a test containing cat question exists and the question is worth (\d+) points$/) do |points|
  pq = FactoryGirl.build :quiz, retake: false, is_draft: false
  pq.save(:validate => false)
  pq.relationships.create!  question_id: @cat_question.id,
                            number: 1,
                            points: points
  @cat_quiz = pq
end

Given(/^a submission of cat test exists where the chosen options are:$/) do |table|
  content = Hash.new
  table.hashes.each do |row|
    content[row[:option]] = "1"
  end 
  student = FactoryGirl.create :student
  @cat_submission = FactoryGirl.create :submission, 
                                       content: content, 
                                       student: student, 
                                       quiz: @cat_quiz
  @cat_taken_quiz = FactoryGirl.create :taken_quiz,
                                       student: student, 
                                       quiz: @cat_quiz

end

When(/^I edit my question$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I click "(.*?)""$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see this text on the bank page for "(.*?)"$/) do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see this text on the bank page for "(.*?)" in "(.*?)" column$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

When(/^the pre\-existing options should be:$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end


Given(/^I am on the Dashboard$/) do
  pending # express the regexp above with the code you wish you had
end

Given(/^I fill "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Given(/^I fill in Options as:$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Given(/^I am grading this question$/) do
  pending # express the regexp above with the code you wish you had
end
