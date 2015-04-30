Given /^I am on the Requests page/ do
  visit staffs_quiz_requests_path
end

When /^cs61as-(.*) and cs61as-(.*) request quizzes for lesson ([0-9])$/ do |name1, name2, lesson|
  student1 = Student.where(login: "cs61as-#{name1}").first
  student2 = Student.where(login: "cs61as-#{name2}").first
  student1.create_quiz_request(lesson: lesson)
  student2.create_quiz_request(lesson: lesson)
end

Then(/^I press "(.*?)" for "(.*?)"$/) do |arg1, arg2|
  first(:button, arg1).click
end