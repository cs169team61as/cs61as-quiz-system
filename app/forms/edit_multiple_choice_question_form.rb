class EditMultipleChoiceQuestionForm < EditQuestionForm
    model :multiple_choice_question

	def validate_and_save(question_params)
		if super
			@me = AbstractQuestion.find id
			form_2_choices(question_params)
			@me.answer = question_params["answer"]
			return false unless @me.valid?
			@me.save
			return true
		else
			return false
		end
	end

	def form_2_choices(question_params)
		choices = Array.new
		ch = question_params["options"]["form_choices"]
		ch.each do |key, text|
			if key =~ /choice_(.*)/
				next if text.blank?
				choices << text
			end
		end
		@me.choices = choices
		@me.options.delete "options"
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