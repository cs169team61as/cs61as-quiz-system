And(/^true false question "(.*?)" exists$/) do |content|
  q = TrueFalseQuestion.build content: content, lesson: 2, 
                                   difficulty: "Easy",
                                   my_rubric: "empty", my_solution: "True"
  q.save!
  @cat_question = q
end

Given(/^a submission of cat test exists where the chosen option is "True"$/) do
  content = Hash.new
  content["True"] = "1"
  content["False"] = "0"
  @cat_student = FactoryGirl.create :student, login: "cs61as-gho", email: "student666@gmail.com"
  @cat_submission = FactoryGirl.create :submission, 
                                       content: content, 
                                       student: @cat_student, 
                                       quiz: @cat_quiz,
                                       question_id: @cat_question.id
  @cat_taken_quiz = FactoryGirl.create :taken_quiz,
                                       student: @cat_student, 
                                       quiz: @cat_quiz

end