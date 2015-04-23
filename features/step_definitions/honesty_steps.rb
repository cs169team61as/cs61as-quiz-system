Then /^selected time should be "(.*)" minutes/ do |expected_time|
  quiz_time = find_by_id "quiz_time"
  selected_time = quiz_time.value
  expect(expected_time).to eq selected_time
end