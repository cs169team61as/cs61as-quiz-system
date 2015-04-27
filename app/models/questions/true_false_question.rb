class TrueFalseQuestion < AbstractQuestion
  option_accessor :choice, :answer
  
  def self.build(h={})
    q = super
    q
  end
  
  def autograde(content, quiz_id)
    if content == choice
      return give_full_credit "The answer matches my solution", quiz_id
    else
      return give_no_credit "The answer does not match my solution"
    end
  end

  def human_readable(content)
    res = "Selected answer:\n\n"
    res << " * #{content}\n"
    res
  end

  def my_solution
    res = ""
    res << " *#{choice}\n" if choice
    #return "(no correct answer)" if res.blank?
    res
  end
  
  def self.choices
    [%w(True True), %w(False False)]
  end
  
end