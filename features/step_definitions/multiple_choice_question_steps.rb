Given(/^the "(.*?)" multiple choice question "(.*?)" exists in "(.*?)" bank:$/) do |name, content, lesson, table|
  choices =Array.new
  table.hashes.each do |row|
    choices << row[:option]
    correct = row[:option] if row[:correct] == "correct"
  end
  correct = choices.find_index correct
  correct ||= "-1"
  
  q = MultipleChoiceQuestion.build content: content, lesson: lesson, 
                                   difficulty: "Easy", choices: choices,
                                   answer: correct,
                                   my_rubric: "(nothing)", my_solution: "(nothing)"
  q.save!
  eval("@#{name}_question = q")
end

Given(/^a test containing "(.*?)" question exists and the question is worth (\d+) points$/) do |name, points|
  pq = FactoryGirl.build :quiz, retake: false, is_draft: false
  pq.save!(:validate => false)
  pq.relationships.create!  question_id: eval("@#{name}_question.id"),
                            number: 1,
                            points: points
  eval("@#{name}_quiz = pq")
end

When(/^I edit the "(.*?)" question$/) do |name|
	visit edit_staffs_question_path(eval("@#{name}_question.id"))
end

Then(/^I should see "(.*?)" on the view page for the "(.*?)" question in "(.*?)"$/) do |text, name, area|
  visit staffs_question_path(eval("@#{name}_question.id"))
  within("div##{area.downcase}") do
    expect(page).to have_content(text)
  end
end

Given(/^the "(.*?)" question should recognize "(.*?)" as a "(.*?)" answer$/)  do |name, choice, correct|
  question = eval("@#{name}_question")
  question.reload
  if question.is_a? MultipleChoiceQuestion
  	index = question.choices.find_index correct
	expect(question.answer).to eq index.to_s	
  elsif question.is_a? AllThatAppliesQuestion
	expect(question.choices[choice]).to eq (correct == "correct")
  else
  	fail "I don't know how to handle this question type (#{question.partial})"
  end
end



Given(/^I am grading the "(.*?)" question$/) do |name|
  student = eval("@#{name}_student")
  quiz =  eval("@#{name}_quiz")
  visit staffs_student_quiz_path(student.id, quiz.id)
  click_link "Grade Question!"
end

Given(/^a submission of the "(.*?)" test exists where the student selected "(.*?)"$/) do |name, selected|
  question = eval("@#{name}_question")
  content = Hash.new
  if question.is_a? MultipleChoiceQuestion
  	content["answer"] = question.choices.find_index(selected).to_s
  elsif question.is_a? TrueFalseQuestion or question.is_a? ShortAnswerQuestion 
	content["answer"] = selected
  else
  	fail "I don't know how to handle this question type (#{question.partial})"
  end

  quiz = eval "@#{name}_quiz"
  question = eval "@#{name}_question"
  student = eval "@#{name}_student"
  student ||= FactoryGirl.create :student, login: "cs61as-gho", email: "student666@gmail.com"
  submission = FactoryGirl.create :submission, 
                                       content: content, 
                                       student: student, 
                                       quiz: quiz,
                                       question_id: question.id
  taken_quiz = FactoryGirl.create :taken_quiz,
                                       student: student, 
                                       quiz: quiz
  eval "@#{name}_student = student"
  eval "@#{name}_submission = submission"
  eval "@#{name}_taken_quiz = taken_quiz"
end

Then(/^the Grade should be "(.*?)"$/) do |grade|
  steps %Q{
    Then Grade should be "#{grade}"
  }
end

When(/^the pre\-existing options of my multiple choice question should be:$/) do |table|
  prefix = "multiple_choice_question_options_"
  table.raw.each_with_index do |row, i|
    expected_choice = row[0]
    expected_correct = row[1] == "correct"
    actual_choice = find_by_id(prefix + "form_choices_choice_#{i}").value
    actual_checkbox = find_by_id(prefix + "correct_#{i}_#{i}")

    expect(actual_choice).to eq expected_choice
    if expected_correct
      actual_checkbox[:checked].should eq "checked"
    else
      actual_checkbox[:checked].should_not eq "checked"
    end
  end
end


Given(/^I fill in Options of my multiple choice question as:$/) do |table|
  prefix = "multiple_choice_question_options_"
  table.raw.each_with_index do |row, i|
    choice = row[0]
    correct = row[1] == "correct"

    fill_in prefix + "form_choices_choice_#{i}", :with => choice
    if correct
      choose prefix + "correct_#{i}_#{i}"
  	end
  end
end