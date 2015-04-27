class TrueFalseQuestion < AbstractQuestion
  option_accessor :choice, :answer
  
  def self.build(h={})
    q = super
    q
  end
  
  def autograde(content, quiz_id)
    student_choices(content) do |text|
      if text == my_solution
        return give_full_credit "The answer matches my solution", quiz_id
      else
        return give_no_credit "The answer does not match my solution"
      end
    end
  end

  def human_readable(content)
    res = "Selected answer:\n\n"
    student_choices(content) do |text|
      res << "* #{text}\n"
    end
    res
  end

  def self.choices
    [%w(True True), %w(False False)]
  end
  
  private
  
  def student_choices(content)
    content.each do |key, value| 
      if content[key] == "1"
        yield key
      end
    end
  end

end