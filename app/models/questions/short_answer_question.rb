class ShortAnswerQuestion < AbstractQuestion
  def autograde(content, quiz_id)
  	if (my_solution == nil) || (my_solution == "")
      return give_no_credit "I don't have a solution for this question"
    end

  	if content["answer"] =~ /#{my_solution}/i
    	return give_full_credit "The answer matches my solution", quiz_id
    else
    	return give_no_credit "The answer doesn't match my solution"
    end
  end

  private

  def give_full_credit(msg, quiz_id)
    res = Hash.new
    res[:credit] = full_credit(quiz_id)
    res[:comment] = msg + " (#{self.partial} autograder)"
    res
  end

  def give_no_credit(msg)
    res = Hash.new
    res[:credit] = 0
    res[:comment] = msg + " (#{self.partial} autograder)"
    res
  end
end