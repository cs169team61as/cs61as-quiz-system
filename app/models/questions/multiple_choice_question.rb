class MultipleChoiceQuestion < AbstractQuestion
=begin



:choices    is an array with the possible answers

            When single_answer is false the student can select any that
            apply. Again, there can be one or more answers with varying
            scores and correctness depending on the rubric.

:answer     id of the answer in :choices that is correct


Sample Question: 

content = "Where do you need to look to cross the strees safely?"
choices = ["Right, then left", "Left, then right", 
          "Up, then down", "It depends"]
answer = 3

q = MultipleChoiceQuestion.build content: content, 
                                 choices: choices, 
                                 answer: answer


TODO - make the question invalid if there are no answer

=end

  option_accessor :choices, :answer

  def self.build(h={})
    q = super
    q.choices ||= Array.new
    q.choices = q.choices.reject { |value| value == "" }
    q.answer ||= -1
    q
  end

  def autograde(content, quiz_id)
    return give_no_credit "This submission is invalid" unless submission_valid(content)
    return give_no_credit "This question is invalid" unless question_valid

    if selected_answer_id(content) == answer
      return give_full_credit "The answer matches my solution", quiz_id
    else
      return give_no_credit "The answer doesn't match my solution"
    end
  end

  # Converts the student's submission content answer into a string
  def human_readable(content)
    selected_answer_text(content)
  end

  # Converts the correct answer into a string
  def my_solution
    correct_answer_text
  end

  private

  # Returns the id of the choice selected by a student
  def selected_answer_id(content)
    content["answer"].to_i
  end

  # Returns the text of the choice selected by a student
  def selected_answer_text(content)
    return "(invalid choice)" unless submission_valid(content)
    return "(invalid question)" unless question_valid
    choices[selected_answer_id(content)]
  end

  # Returns wheter the content of a submission is a valid choice
  def submission_valid(content)
    content["answer"] != nil and content["answer"] =~ /^\d+$/ and valid_choice(selected_answer_id(content))
  end

  # Returns whether the question is valid or not.
  # The be valid the question must:
  # 1) have at least two choices
  # have a valid answer
  def question_valid
    valid_choice(answer) and choices.length >= 2
  end

  # Returns the answer text for this question
  def correct_answer_text
    return "(no correct answer, question invalid)" unless question_valid
    choices[answer]
  end

  # Returns true if the selected answer id is within the range of all possible answers
  # Expects an integer
  def valid_choice(answer_id)
    return false unless answer_id.is_a? Integer
    answer_id >= 0 and answer_id < choices.length
  end
end