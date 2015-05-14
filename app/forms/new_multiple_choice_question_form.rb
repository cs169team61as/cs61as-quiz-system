class NewMultipleChoiceQuestionForm < NewQuestionForm
    model :multiple_choice_question


  def validate_and_save(question_params)
    return false unless validate(question_params)
    MultipleChoiceQuestion.form_2_choices @model, question_params
    return false unless @model.valid?
    save_with_params(question_params)
  end

end