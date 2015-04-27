class NewAllThatAppliesQuestionForm < NewQuestionForm 
	model :all_that_applies_question

	def validate_and_save(question_params)
		if super
			form_2_choices
			@model.save
			return true
		else
			return false
		end
	end

	def form_2_choices
		choices = Hash.new
		ch = @model.options["options"]["form_choices"]
		ch.each do |k, v|
			if k =~ /choice_(.*)/
				new_key = ch[k]
				new_value = ch["correct_#{$1}"] != "0"
				next if new_key.blank?
				choices[new_key] = new_value
			end
		end
		@model.choices = choices
		@model.options.delete "options"
	end

end