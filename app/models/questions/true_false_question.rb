class TrueFalseQuestion < ShortAnswerQuestion
  def self.choices
    [%w(True True), %w(False False)]
  end

  validate do |question|
  	msg = "The only permitted answers are True and False"
  	errors[:my_solution] << msg unless my_solution =~ /^(True|False)$/
  end

  def autograde(content, quiz_id)
    if (my_solution == nil) || (my_solution == "")
      return give_no_credit "[Invalid question] I don't have a solution for this question"
    end

    if content["answer"] == my_solution
      return give_full_credit "The answer matches my solution", quiz_id
    else
      return give_no_credit "The answer doesn't match my solution"
    end
  end
end