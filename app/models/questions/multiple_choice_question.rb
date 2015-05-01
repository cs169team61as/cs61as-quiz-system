class MultipleChoiceQuestion < AbstractQuestion
=begin

:choices    is an array with the possible answers text

:answer     id of the answer in :choices that is correct


Sample Question: 

content = "Where do you need to look to cross the strees safely?"
choices = ["Right, then left", "Left, then right", 
          "Up, then down", "It depends"]
answer = 3

q = MultipleChoiceQuestion.build content: content, 
                                 choices: choices, 
                                 answer: answer

=end

  option_accessor :choices, :answer

  def self.build(h={})
    q = super
    q.choices ||= Array.new
    q.choices = q.choices.reject { |value| value == "" }
    q.answer ||= "-1"
    q
  end

  validate do |question|
    choices_msg = "This multiple choice question needs to have at least two choices"
    answer_msg = "The answer needs to be a valid choice"
    errors[:content] << choices_msg unless has_at_least_two_choices
    errors[:content] << answer_msg unless answer_is_valid
  end

  def autograde(content, quiz_id)
    return give_no_credit "This submission is incorrect" unless submission_valid(content)
    return give_no_credit "This question is invalid" unless question_valid

    if selected_answer_id(content) == answer
      return give_full_credit "The answer matches my solution", quiz_id
    else
      return give_no_credit "The answer doesn't match my solution"
    end
  end

  # Converts the student's submission content answer into a string
  def human_readable(content); selected_answer_text(content); end

  # Converts the correct answer into a string
  def my_solution; correct_answer_text; end

  private

  # Returns the id of the choice selected by a student
  def selected_answer_id(content); content["answer"]; end

  # Returns the text of the choice selected by a student
  def selected_answer_text(content)
    return "(invalid choice)" unless submission_valid(content)
    return "(invalid question)" unless question_valid
    choices[selected_answer_id(content).to_i]
  end

  # Returns wheter the content of a submission is a valid choice
  def submission_valid(content)
    chosen_option_is_numeric(content) and chosen_option_exists(content)
  end

  def chosen_option_is_numeric(content); content["answer"] != nil and content["answer"] =~ /^\d+$/; end
  def chosen_option_exists(content); valid_choice(selected_answer_id(content).to_i); end

  # Returns whether the question is valid or not
  def question_valid
    has_at_least_two_choices and answer_is_valid
  end

  def answer_is_valid; valid_choice(answer.to_i); end
  def has_at_least_two_choices; choices.length >= 2; end

  # Returns the answer text for this question
  def correct_answer_text
    return "(no correct answer, question invalid)" unless question_valid
    choices[answer.to_i]
  end

  # Returns true if the selected answer id is within the range of all possible answers
  # Expects an integer
  def valid_choice(answer_id)
    return false unless answer_id.is_a? Integer
    answer_id >= 0 and answer_id < choices.length
  end
end