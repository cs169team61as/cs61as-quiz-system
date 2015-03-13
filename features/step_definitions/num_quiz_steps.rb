Given /^that I am on the (.*) dashboard/ do |user_type|
  visit user_session_path
  if user_type == "staff"
    fill_in "Login", :with=> "cs61as-ta"
  else
    fill_in "Login", :with=> "cs61as-aa"
  end
  fill_in "Password", :with=> "password"
  click_button "Sign in"
end

Then /^I must see (.*)/ do |expected|
  visit staffs_dashboard_index_path
  page.should have_content(text)
end
  
When /^I press (.*) link/ do |expected|
  find(:xpath, "//a[@href='/staffs/grades']").click
end
