class NewTrueFalseQuestionForm < NewQuestionForm 
	model :true_false_question

	def check_solution
		@model.valid?
  	end
end