# Creates a Question
class CreateQuestion
  def self.call(question_params)
    question = AbstractQuestion.new question_params
    solution = Solution.new question_params.delete question.options["solution"]#:solution_attributes
    rubric = Rubric.new question_params.delete question.options["rubric"] #:rubric_attributes

    question.solution = solution
    question.rubric = rubric
    question.save
  end
end
