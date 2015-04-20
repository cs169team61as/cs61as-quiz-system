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

  def self.build(h={})
    q = super
    q.choices ||= Hash.new
    q.choices = q.choices.reject { |k, v| k == "" }
    q
  end


  def autograde(content, quiz_id)
    # if (answers == nil)
    #   return give_no_credit "I don't have a solution for this question"
    # end

    @full_credit = full_credit(quiz_id)
    score = calculate_score content, quiz_id

    if score
      if score == @full_credit
        return give_full_credit "The answer matches my solution", quiz_id
      else
        return give_partial_credit score, "The answer partially matches my solition", quiz_id
      end
      return give_no_credit "The answer doesn't match my solution"
    end
  end

  def human_readable(content)
    res = "Selected answers:\n\n"
    content.each { |text, x| res << " * #{text}\n" }
    res
  end

  def my_solution
    res = ""
    choices.each do |k, v|
      res << " * #{k}\n" if v
    end
    return "(no correct answer)" if res.blank?
    res
  end


  private

  def calculate_score(content, quiz_id)
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

    score = pre_score.to_f / total_correct_answers * @full_credit
    normalize score, quiz_id
  end
end