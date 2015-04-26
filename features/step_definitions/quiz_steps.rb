When /^The (.*) cs61as-(.*) exists$/ do |type, name|
  type[0] = type[0].capitalize
  Object.const_get(type).create!(first_name: type, last_name: "Test", email: "test#{name}@test.com", password: "password", login: "cs61as-#{name}")
end

When /^A Quiz for lesson ([0-9]) exists$/ do |lesson|
  q = Quiz.create!(lesson: lesson, version: 1, is_draft: false)
  q1 = AbstractQuestion.build content: "This is a test quiz", 
                              lesson: lesson, difficulty: "Easy",
                              my_solution: "yup", my_rubric: "This is a test rubric"
  q1.save
  q1.relationships.create!(quiz_id: q.id, number: 1, points: 10)
end

Given(/^the web site is set up$/) do
  step "The Student cs61as-st exists"
  step "The Gsi cs61as-ta exists"
  step "A Quiz for lesson 1 exists"
  step "A Quiz for lesson 2 exists"
end

When /^cs61as-(.*) requests a quiz for lesson ([0-9])$/ do |name, lesson|
  student = Student.where(login: "cs61as-#{name}").first
  student.create_quiz_request(lesson: lesson)
end

When /^cs61as-(.*) is logged in$/ do |name|
  visit "/users/sign_in"
  fill_in("Login", :with => "cs61as-#{name}")
  fill_in("Password", :with => "password")
  click_button("Sign in")
end
