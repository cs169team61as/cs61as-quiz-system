class NewMultipleChoiceQuestionForm < NewQuestionForm
    model :multiple_choice_question


  def validate_and_save(question_params)
    return false unless validate(question_params)
    form_2_choices
    return false unless @model.valid?
    pts = question_params.delete :points
    @model.save 
    @model.solution.update_attribute(:question_id, @model.id)
    @model.rubric.update_attribute(:question_id, @model.id)
    @model.my_solution = question_params[:my_solution]
    @model.my_rubric = question_params[:my_rubric]
    update_points(pts)
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