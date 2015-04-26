Given(/^I am on the Staging Page$/) do
  visit new_user_session_path
end

Given(/^the login placeholder should be "(.*)"$/) do |placeholder|
  login_field = find_by_id "user_login"
  expect(login_field[:placeholder]).to eq placeholder
end
