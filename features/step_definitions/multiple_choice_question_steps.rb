Given(/^the "(.*?)" multiple choice question "(.*?)" exists in "Lesson (\d+)" bank:$/) do |name, content, lesson, table|
  choices = Hash.new
  table.hashes.each do |row|
    choices[row[:option]] = (row[:correct] == "correct")
  end
  q = MultipleChoiceQuestion.build content: content, lesson: lesson,
                                   difficulty: "Easy", choices: choices,
                                   my_rubric: "(nothing)", my_solution: "(nothing)"
  q.save!
  eval("@#{name}_question = q")
end

Given(/^a test containing cat question exists and the question is worth (\d+) points$/) do |points|
  pq = FactoryGirl.build :quiz, retake: false, is_draft: false
  pq.save!(:validate => false)
  pq.relationships.create!  question_id: @cat_question.id,
                            number: 1,
                            points: points
  @cat_quiz = pq
end

Given(/^a submission of cat test exists where the chosen options are:$/) do |table|
  content = Hash.new
  table.hashes.each_with_index do |row, id|
    content["choice_#{id}"] = row["option"]
    content["correct_#{id}"] = (row["correct"] == "correct" ? "1" : "0")
  end

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

Given(/^I fill in Options as:$/) do |table|
  prefix = "multiple_choice_question_options_form_choices_"
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

When(/^I edit the cat question$/) do
  visit edit_staffs_question_path(@cat_question.id)
end

Then(/^I should see "(.*?)" on the view page for the cat question in "(.*?)"$/) do |text, area|
  visit staffs_question_path(@cat_question.id)
  within("div##{area.downcase}") do
    expect(page).to have_content(text)
  end
end

When(/^the pre\-existing options should be:$/) do |table|
  prefix = "multiple_choice_question_options_form_choices_"
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

Given(/^I am grading the cat question$/) do
  visit staffs_student_quiz_path(@cat_student.id, @cat_quiz.id)
  click_link "Grade Question!"
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

Then(/^the cat question should recognize "(.*?)" as a "(.*?)" answer$/) do |choice, correct|
  @cat_question.reload
  expect(@cat_question.choices[choice]).to eq (correct == "correct")
end