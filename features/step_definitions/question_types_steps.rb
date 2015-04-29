def make_quiz(question_id)
  pq = FactoryGirl.build :quiz, retake: false, is_draft: false
  pq.save!(:validate => false)
  pq.relationships.create!  question_id: question_id,
                            number: 1,
                            points: 10
  pq
end

Given(/^a quiz with an all that applies question "(.*?)" exists:$/) do |content, table|
  choices = Hash.new
  table.hashes.each do |row|
    choices[row[:option]] = (row[:correct] == "correct")
  end
  q = AllThatAppliesQuestion.build content: content, 
                                   difficulty: "Easy", choices: choices,
                                   my_rubric: "(nothing)", my_solution: "(nothing)"
  q.save!
  @this_quiz = make_quiz(q.id)
  @this_question = q
end


Given(/^a quiz with a short answer question "(.*?)" and answer "(.*?)" exists$/) do |content, answer|
  q = ShortAnswerQuestion.build content: content, 
                                   difficulty: "Easy",
                                   my_rubric: "(nothing)",
                                   my_solution: answer
  q.save!
  @this_quiz = make_quiz(q.id)
  @this_question = q
end

Given(/^a quiz with a true false question "(.*?)" and answer "(.*?)" exists$/) do |content, answer|
  q = TrueFalseQuestion.build content: content,
                              difficulty: "Easy",
                              my_rubric: "empty",
                              my_solution: answer
  q.save!
  @this_quiz = make_quiz(q.id)
  @this_question = q
end

Given(/^a quiz with a multiple choice question "(.*?)" and answer "(.*?)" exists:$/) do |arg1, arg2, table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Given(/^a quiz with a scheme code question "(.*?)" and answer "(.*?)" exists$/) do |content, answer|
  pending # express the regexp above with the code you wish you had
end

Given(/^I am taking this quiz$/) do
  FactoryGirl.create :quiz_lock, student: @student, quiz: @this_quiz 
  visit take_students_quizzes_path
end


Then(/^I want to see this short answer question question with these options in the quiz$/) do
  expect(page).to have_content @this_question.content
end


Then(/^I want to see this all that applies question with these options in the quiz$/) do
  expect(page).to have_content @this_question.content
  @this_question.choices.each { |key, value| expect(page).to have_content key}
end


Then(/^I want to see this multiple choice question with these options in the quiz$/) do
  pending # express the regexp above with the code you wish you had
end


Then(/^I want to see this true\/false question with these options in the quiz$/) do
  pending # express the regexp above with the code you wish you had
end


Then(/^I want to see this schema question with these options in the quiz$/) do
  pending # express the regexp above with the code you wish you had
end
