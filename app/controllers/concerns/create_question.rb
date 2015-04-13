# Creates a Question
class CreateQuestion
  def self.call(question_params)
    question = AbstractQuestion.new question_params
    solution = Solution.new question_params.delete :solution_attributes
    rubric = Rubric.new question_params.delete :rubric_attributes
    solution.content = question.make_solution
    rubric.rubric = question.make_rubric

    question.solution = solution
    question.rubric = rubric
    question
  end
end
