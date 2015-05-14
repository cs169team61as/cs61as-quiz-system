class EditAllThatAppliesQuestionForm < EditQuestionForm 
	model :all_that_applies_question

	def validate_and_save(question_params)
		question = AbstractQuestion.find id
    	return false unless validate_params(question, question_params)
    	AllThatAppliesQuestion.form_2_choices(question, question_params)
		return false unless question.valid?
    	question.save
	end


	def populate_form_fields
		form_choices = Hash.new
		@model.choices.each_with_index do |h, i|
			k = h[0]
			v = h[1]
			form_choices["choice_#{i}"] = k
			form_choices["correct_#{i}"] = v
		end
		@model.options["options"] = Hash.new
		@model.options["options"]["form_choices"] = form_choices
	end
end