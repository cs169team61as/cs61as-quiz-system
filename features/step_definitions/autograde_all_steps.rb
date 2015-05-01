Given(/^the follwing all that applies question "(.*?)" with id "(.*?)" exists in lesson "(.*?)"$/) do |question, id, lesson, table|
  # table is a Cucumber::Ast::Table
  #pending # express the regexp above with the code you wish you had
  choices = Hash.new
  table.hashes.each do |row|
    choices[row[:option]] = (row[:correct] == "correct")
  end
  q = AllThatAppliesQuestion.build content: question, lesson: lesson, 
                                   difficulty: "Easy", choices: choices,
                                   my_rubric: "(nothing)", my_solution: "(nothing)"
  q.id = id
  q.save!
end

Given(/^a test with id "(.*?)" with only question id "(.*?)" exists$/) do |test_id, question_id|
  q = AllThatAppliesQuestion.find_by_id(question_id)
  pq = FactoryGirl.build :quiz, retake: false, is_draft: false
  pq.id = test_id
  pq.save!(:validate => false)
  pq.relationships.create!  question_id: q.id,
                            number: 1,
                            points: 10
end

Given(/^that "(.*?)" with login "(.*?)" and password "(.*?)" and id "(.*?)" exists$/) do |type, login, password, id|
  user_type = type.to_sym
  user = FactoryGirl.create user_type, login: login, email: login + "@gmail.com"
  user.id = id
  user.save!(:validate => false)

end



Given(/^a quiz submission with id "(.*?)" with question id "(.*?)", user id "(.*?)", with options$/) do |quiz_id, question_id, user_id, table|
  content = Hash.new
  table.hashes.each_with_index do |row, id|
    content["choice_#{id}"] = row["option"]
    content["correct_#{id}"] = (row["correct"] == "correct" ? "1" : "0")
  end 

  #student = FactoryGirl.create :student, login: "cs61as-gho", email: "student666@gmail.com"
  student = Student.find_by_id(user_id)
  question = AllThatAppliesQuestion.find_by_id(question_id)
  quiz = Quiz.find_by_id(quiz_id)
  submission = FactoryGirl.create :submission, 
                                   content: content, 
                                   student: student, 
                                   quiz: quiz,
                                   question_id: question.id
  taken_quiz = FactoryGirl.create :taken_quiz,
                                   student: student, 
                                   quiz: quiz
end

Given(/^that I am grading the quiz with id "(.*?)" done by student "(.*?)"$/) do |quiz_id, student_id|
  visit staffs_student_quiz_path(student_id, quiz_id)
  click_link "Grade Question!"
end

