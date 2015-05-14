class EditMultipleChoiceQuestionForm < EditQuestionForm
    model :multiple_choice_question

	def validate_and_save(question_params)
		question = AbstractQuestion.find id
    	return false unless validate_params(question, question_params)
    	MultipleChoiceQuestion.form_2_choices(question, question_params)
		question.answer = question_params["answer"]
		return false unless question.valid?
    	question.save
	end

	def populate_form_fields
		form_choices = Hash.new
		@model.choices.each_with_index do |text, i|
			form_choices["choice_#{i}"] = text
		end
		@model.options["options"] = Hash.new
		@model.options["options"]["form_choices"] = form_choices
	end
end