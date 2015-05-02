class NewAllThatAppliesQuestionForm < NewQuestionForm 
	model :all_that_applies_question


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