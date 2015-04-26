
Given /^I am taking a quiz/ do
  unless @quiz and @quizlock
    @quiz = FactoryGirl.create :quiz
    @question = FactoryGirl.create :short_answer_question
    @quiz.relationships.create!  question_id: @question.id,
                              number: 1,
                              points: 10
    @quizlock = FactoryGirl.create :quiz_lock, student: @student, quiz: @quiz 
  end
  visit take_students_quizzes_path
end

When /^I finish the quiz/ do
  check("honesty_statement")
  click_button("Submit")
end

