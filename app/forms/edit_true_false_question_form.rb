class EditTrueFalseQuestionForm < EditQuestionForm 
	model :true_false_question

	def check_solution(question)
		return question.valid?
  	end
end