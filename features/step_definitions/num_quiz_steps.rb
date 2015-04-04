include Warden::Test::Helpers
Warden.test_mode!


Given /^I am logged in as a (staff user|student)/ do |user_type|
  logout(:user)
  visit new_user_session_path
  if user_type == "staff user"
    @staff ||= create :staff, login: "cs61as-ab" 
    fill_in "Login", :with => @staff.login
    fill_in "Password", :with => @staff.password
  elsif user_type == "student"
    @student ||= create :student, login: "cs61as-aou"
    fill_in "Login", :with => @student.login
    fill_in "Password", :with => @student.password
  end
  click_button "Sign in"
  expect(page).to have_content "Welcome"
  expect(page).to have_content "Dashboard"
end

Given(/there are (\d+) quizzes to grade/) do |num|
  1.upto(num.to_i) do |i|
    TakenQuiz.create  student_id: 1,
                         quiz_id: i,
                           login: "cs61as-aou",
                         comment: "hello",
                        finished: false
  end
end

Given /^I am on the Questions page/ do
  visit staffs_questions_path
end

Given /^I am on the Grading page/ do
  visit staffs_grades_path
end

When /^I try to add a new question/ do
  visit new_staffs_question_path
end


Then /^I must see "([^\"]*)"$/ do |expected|
  if expected == "staff"
  	visit staffs_dashboard_index_path
  else
  	visit students_dashboard_path
  end
  page.should have_content(expected)
end

When /^I press (.*) link/ do |expected|
  find(:xpath, "//a[@href='/staffs/grades']").click
end
