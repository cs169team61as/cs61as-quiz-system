Given(/^the "(.*?)" all that applies question "(.*?)" exists in "Lesson (\d+)" bank:$/) do |name, content, lesson, table|
  choices = Hash.new
  table.hashes.each do |row|
    choices[row[:option]] = (row[:correct] == "correct")
  end
  q = AllThatAppliesQuestion.build content: content, lesson: lesson, 
                                   difficulty: "Easy", choices: choices,
                                   my_rubric: "(nothing)", my_solution: "(nothing)"
  q.save!
  eval("@#{name}_question = q")
end

Given(/^a submission of the "(.*?)" test exists where the chosen options are:$/) do |name, table|
  content = Hash.new
  table.hashes.each_with_index do |row, id|
    content["choice_#{id}"] = row["option"]
    content["correct_#{id}"] = (row["correct"] == "correct" ? "1" : "0")
  end 

  question = eval("@#{name}_question")
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

Given(/^I fill in Options of my all that applies question as:$/) do |table|
  prefix = "all_that_applies_question_options_form_choices_"
  table.raw.each_with_index do |row, i|
    choice = row[0]
    correct = row[1] == "correct"

    fill_in prefix + "choice_#{i}", :with => choice
    if correct
      check prefix + "correct_#{i}"
    else
      uncheck prefix + "correct_#{i}"
    end
  end
end


When(/^the pre\-existing options of my all that applies question should be:$/) do |table|
  prefix = "all_that_applies_question_options_form_choices_"
  table.raw.each_with_index do |row, i|
    expected_choice = row[0]
    expected_correct = row[1] == "correct"
    actual_choice = find_by_id(prefix + "choice_#{i}").value
    actual_checkbox = find_by_id(prefix + "correct_#{i}")

    expect(actual_choice).to eq expected_choice
    if expected_correct
      actual_checkbox.should be_checked
    else
      actual_checkbox.should_not be_checked
    end
  end
end

Then(/^I should see "(.*?)" on the bank page for "Lesson (\d+)"$/) do |text, lesson|
  visit  bank_staffs_questions_path + "?add=false&lesson=#{lesson}"
  expect(page).to have_content(text)
end

When(/^check "Option (\d+)" as correct$/) do |id|
  prefix = "all_that_applies_question_options_form_choices_"
  option_id = id.to_i - 1
  check prefix + "correct_#{option_id}"
end

Given(/^I create a new quiz$/) do
  click_link "Create a New Quiz!"
  select("3", from: "quiz_lesson")
  fill_in("quiz_version", with: "666")
  click_button "Update!"
  expect(page).to have_content "3a666"
  click_link("Quiz 3a666 (Draft)")
  click_link "Edit Quiz"
end


Then(/^"(.*?)" should contain "(.*?)"$/) do |area, text|
  within("div##{area.downcase}") do
    text.split(/, /).each { |str| expect(page).to have_content(str) }
  end
end

Then(/^"(.*?)" should not contain "(.*?)"$/) do |area, text|
  within("div##{area.downcase}") do
    text.split(/, /).each { |str| expect(page).to have_no_content(str) }
  end
end

Then(/^Grade should be "(.*?)"$/) do |grade|
  actual_grade = find_by_id("grade_grade").value
  expect(actual_grade).to eq grade
end
