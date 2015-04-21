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


 So far the formula for calculating the grade is this:

  points_per_choice = full_credit / total_correct_choices
  credit = (correct_choices - incorrect_choices) * points_per_choice

=end

  option_accessor :choices, :single_answer, :answers

  def self.build(h={})
    q = super
    q.choices ||= Hash.new
    q.choices = q.choices.reject { |k, v| k == "" }
    q
  end


  def autograde(content, quiz_id)
    score = calculate_score content, quiz_id
    return give_partial_credit score, reason, quiz_id
  end

  def human_readable(content)
    res = "Selected answers:\n\n"
    content.each { |text, x| res << " * #{text}\n" unless x == "0" }
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

  def reason
    res = "Selected correctly:\n\n" 
    if @correct_choices.length != 0
      @correct_choices.each { |ch| res << (" * #{ch} (+ #{@points_per_choice.round(1)})\n") }
    else
      res << ("(nothing)\n")
    end

    res << "\nSelected incorrectly:\n\n"
    if @incorrect_choices.length != 0
      @incorrect_choices.each { |ch| res << (" * #{ch} (- #{@points_per_choice.round(1)})\n") }
    else
      res << ("(nothing)\n")
    end
    res
  end

  def calculate_score(content, quiz_id)

    @total_correct_choices = 0
    choices.each do |key, value|
      @total_correct_choices += 1 if value
    end

    @full_credit = full_credit(quiz_id)
    @points_per_choice = @full_credit / @total_correct_choices

    @correct_choices = Array.new
    @incorrect_choices = Array.new
    content.each do |key, value|
      if value != "0"
        if choices[key]
          @correct_choices << key
        else
          @incorrect_choices << key
        end
      end
    end

    score = (@correct_choices.length - @incorrect_choices.length) * @points_per_choice
    normalize score, quiz_id
  end
end