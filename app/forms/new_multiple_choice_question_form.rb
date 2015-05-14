class NewMultipleChoiceQuestionForm < NewQuestionForm
    model :multiple_choice_question


  def validate_and_save(question_params)
    return false unless validate(question_params)
    form_2_choices
    save_with_params(question_params)
  end

  def form_2_choices
	choices = Array.new
	ch = @model.options["options"]["form_choices"]
	ch.each do |key, text|
		if key =~ /choice_(.*)/
			next if text.blank?
			choices << text
		end
	end
	@model.choices = choices
	@model.options.delete "options"
  end

end