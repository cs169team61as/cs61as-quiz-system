class AllThatAppliesQuestion < AbstractQuestion
=begin



:choices    is a hash with the options (string) and whether or
            it is a correct answer

            When single_answer is true the student only has to select
            one option. There can be one or more answers which are
            correct

            When single_answer is false the student can select any that
            apply. Again, there can be one or more answers with varying
            scores and correctness depending on the rubric.

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

  validate do |question|
    choices_msg = "This all that applies question needs to have at least two choices"
    correct_msg = "This all that applies question needs to have at least one correct choice"

    errors[:content] << choices_msg unless has_at_least_two_choices
    errors[:content] << correct_msg unless has_at_least_one_correct_choice
  end

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

  # Converts the student's submission content answer into a string
  def human_readable(content)
    res = "Selected answers:\n\n"
    student_choices(content) do |text, is_selected|
      res << " * #{text}\n" if is_selected
    end
    res
  end

  # Converts the correct answer into a string
  def my_solution
    res = ""
    choices.each do |k, v|
      res << " * #{k}\n" if v
    end
    return "(no correct answer)" if res.blank?
    res
  end


  #Parses the form fields into the valid choices hash
  def self.form_2_choices(question, question_params)
    choices = Hash.new
    ch = question_params["options"]["form_choices"]
    ch.each do |k, v|
      if k =~ /choice_(.*)/
        new_key = ch[k]
        new_value = ch["correct_#{$1}"] != "0"
        next if new_key.blank?
        choices[new_key] = new_value
      end
    end
    question.choices = choices
    question.options.delete "options"
  end

  private

  def has_at_least_two_choices
    choices.length >= 2
  end

  def has_at_least_one_correct_choice
    choices.values.count(true) >= 1
  end

  # Returns the comment produced by the autograder
  def reason
    res = "Selected correctly:\n\n"
    res <<  make_list(@correct_choices, @points_per_choice.round(1))
    res << "\n"
    res << "Selected incorrectly:\n\n"
    res <<  make_list(@incorrect_choices, -@points_per_choice.round(1))
  end

  # Helper function to generate the comment produced by the autograder.
  # list is the array of the answers selected, points is how much
  # points is given (or taken off) for each of these answer
  def make_list(list, points)
    res = ""
    pts = points >= 0 ? "(+ #{points})" : "(- #{-points})" 
    if list.length != 0
      list.each { |ch| res << (" * #{ch} #{pts}\n") }
    else
      res << ("(nothing)\n")
    end
    res
  end

  # Iterates over the student's choices, given the content of
  # the student's submission
  # example of use: 
  # student_choices(content) do |text, is_selected|
  # ...
  # end
  def student_choices(content)
    content.each do |key, value| 
      if key =~ /choice_(.*)/
        text = content[key]
        is_selected = content["correct_#{$1}"] == "1"
        yield text, is_selected
      end
    end
  end

  # Calculated the grade given the student's, given the content of
  # the student's submission and the quiz.
  #
  # So far the formula for calculating the grade is this:
  # points_per_choice = full_credit / total_correct_choices
  # credit = (correct_choices - incorrect_choices) * points_per_choice
  def calculate_score(content, quiz_id)
    @total_correct_choices = 0
    choices.each do |key, value|
      @total_correct_choices += 1 if value
    end

    @full_credit = full_credit(quiz_id)
    @points_per_choice = @full_credit / @total_correct_choices

    @correct_choices = Array.new
    @incorrect_choices = Array.new

    student_choices(content) do |text, is_selected|
      if is_selected
        if choices[text]
          @correct_choices << text
        else
          @incorrect_choices << text
        end
      end
    end

    score = (@correct_choices.length - @incorrect_choices.length) * @points_per_choice
    normalize score, quiz_id
  end
end