class NewAllThatAppliesQuestionForm < NewQuestionForm 
	model :all_that_applies_question

  	def validate_and_save(question_params)
  		return false unless validate(question_params)
    	AllThatAppliesQuestion.form_2_choices @model, question_params
    	save_with_params(question_params)
    end

end