class ShortAnswerQuestion < AbstractQuestion
  def autograde(answer, quiz_id)
  	res = Hash.new
  	if answer =~ /#{my_solution}/i
    	res[:credit] = full_credit(quiz_id)
    	res[:comment] = "The answer matches my solution (#{q.partial} autograder)"
    else
    	res[:credit] = 0
    	res[:comment] = "The answer doesn't match my solution (#{q.partial} autograder)"
    end
    res
  end
end