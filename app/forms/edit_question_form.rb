# Edit question here
class EditQuestionForm < Reform::Form

  property :id
  property :content
  property :lesson
  property :difficulty

  property :my_solution 
  validates :content, presence: true

  property :my_rubric
  validates :my_rubric, presence: true

  validates :content, :lesson, presence: true
  validates :difficulty, presence: true
  validate :check_solution
  validate :check_rubric

  def validate_and_save(question_params)
    question = AbstractQuestion.find id
    question.my_solution = question_params[:my_solution]
    question.my_rubric = question_params[:my_rubric]
    question.content = question_params[:content]
    question.difficulty = question_params[:difficulty]
    question_params = update_points(question_params)
    return false unless validate(question_params)
    question.save
  end

  def populate_form_fields; end

  def check_solution
    if @model.my_solution.blank?
      errors.add :content, "Doesn't have solution."
    end
  end

  def check_rubric
    if @model.my_rubric.blank?
      errors.add :rubric, "Doesn't have rubric."
    end
  end

  def update_points(params)
    unless params[:points][:pts].blank? || params[:points][:qid].blank?
      rlt = Relationship.find_by quiz_id: params[:points][:qid],
                                 question_id: id
      rlt.update_attribute(:points, params[:points][:pts])
    end
    params.delete :points
    params
  end
end
