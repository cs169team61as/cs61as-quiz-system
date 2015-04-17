class MultipleChoiceQuestion < AbstractQuestion
=begin


Multiple Choice Questions can either be select one OR select
all that apply. This will be defined by option single_answer which
is true when there is only one choice needs to be selected to answer.

:choices    is a hash with the options (string) and whether or
            it should be checked.

            When single_answer is true the student only has to select
            one option. There can be one or more answers which are
            correct

            When single_answer is false the student can select any that
            apply. Again, there can be one or more answers with varying
            scores and correctness depending on the rubric.

:single_answer  True when MCQ is a single answer question, false otherwise

:answers    Hash of all the potential answers and their respective scores

=end

  option_accessor :choices, :single_answer, :answers

  def autograde(answer, quiz_id)
    if (answers == nil)
      return give_no_credit "I don't have a solution for this question"
    end

    score = answers.try(:[],answer)
    if score
      if score == full_credit(quiz_id)
        return give_full_credit "The answer matches my solution"
      else
        return give_partial_credit(score, "The answer partially matches my solition")

    return give_no_credit "The answer doesn't match my solution"
  end

  private

  def give_partial_credit(score, msg, quiz_id)
    res = Hash.new
    res[:credit] = full_credit(quiz_id)
    res[:comment] = msg + "(#{q.partial} autograder)"
    res
  end

  def give_full_credit(msg, quiz_id)
    res = Hash.new
    res[:credit] = full_credit(quiz_id)
    res[:comment] = msg + "(#{q.partial} autograder)"
    res
  end

  def give_no_credit(msg)
    res = Hash.new
    res[:credit] = 0
    res[:comment] = msg + "(#{q.partial} autograder)"
    res
  end
end