Given /^that I am on the (.*) dashboard/ do |user_type|
  visit user_session_path
  if user_type == "staff"
    fill_in 'Login', :with=> 'cs61a-ta'
  else
    fill_in 'Login', :with=> 'cs61a-aa'
  end
  fill_in 'Password', :with=> 'password'
  click_button 'Sign in'
end

