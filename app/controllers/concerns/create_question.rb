# Creates a Question
class CreateQuestion
  def self.call(question_params, question_type)
    question = question_type.classify.constantize.build question_params
    solution = Solution.new question_params.delete :solution_attributes
    rubric = Rubric.new question_params.delete :rubric_attributes

    question.solution = solution
    question.rubric = rubric
    question
  end
end
