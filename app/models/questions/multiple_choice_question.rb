class MultipleChoiceQuestion < AbstractQuestion
=begin


Multiple Choice Questions can either be select one OR select
all that apply. This will be defined by option single_answer which
is true when there is only one choice needs to be selected to answer.

:choices    is a hash with the options (string) and whether or
            it is a correct answer

            When single_answer is true the student only has to select
            one option. There can be one or more answers which are
            correct

            When single_answer is false the student can select any that
            apply. Again, there can be one or more answers with varying
            scores and correctness depending on the rubric.

:single_answer  True when MCQ is a single answer question, false otherwise
(maybe we should just inherit from this class, to update the 
partials name automatically, like
SimpleChoiceQuestion < MultipleChoiceQuestion

:answers    Hash of all the potential answers and their respective scores

Sample Question: "Which numbers are larger than 0 smaller than 2?"

  :choices is {"0"=>false, "1"=>true, "2" =>false}
  :single_answer is false
  :answers is [[false,true,true]=>2, [false,true,false]=>1
                , [false,false,true]=>1, [true,true,true]=>1]

  Note: Answer representation up for discussion/change

=end

  option_accessor :choices, :single_answer, :answers

  def autograde(content, quiz_id)
    # if (answers == nil)
    #   return give_no_credit "I don't have a solution for this question"
    # end

    @full_credit = full_credit(quiz_id)
    score = calculate_score(content)

    if score
      if score == @full_credit
        return give_full_credit "The answer matches my solution"
      else
        return give_partial_credit(score, "The answer partially matches my solition")
      end
      return give_no_credit "The answer doesn't match my solution"
    end
  end

  private

  def calculate_score(content)
    total_correct_answers = 0
    choices.each do |key, value|
      total_correct_answers += 1 if value 
    end

    pre_score = 0
    content.each do |key, value|
      if choices[key]
        pre_score += 1
      else
        pre_score -= 1
      end
    end

    score = pre_score / total_correct_answers * @full_credit
    score = score >= 0 ? score : 0
    score = score <= @full_credit ? score : @full_credit
  end

  def give_partial_credit(score, msg)
    res = Hash.new
    res[:credit] = score
    res[:comment] = msg + "(#{self.partial} autograder)"
    res
  end

  def give_full_credit(msg)
    res = Hash.new
    res[:credit] = @full_credit
    res[:comment] = msg + "(#{self.partial} autograder)"
    res
  end

  def give_no_credit(msg)
    res = Hash.new
    res[:credit] = 0
    res[:comment] = msg + "(#{self.partial} autograder)"
    res
  end
end