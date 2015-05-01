And(/^true false "(.*?)" question "(.*?)" exists in lesson "(.*?)" bank and the answer is "(.*?)"$/) do |name, content, lesson, answer|
  q = TrueFalseQuestion.build content: content, lesson: lesson, 
                                   difficulty: "Easy",
                                   my_rubric: "empty", my_solution: answer
  q.save!
  eval("@#{name}_question = q")
end
