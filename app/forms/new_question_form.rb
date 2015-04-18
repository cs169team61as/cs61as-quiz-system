# Edit question here
class NewQuestionForm < Reform::Form
  model :abstract_question

  property :id
  property :content
  property :lesson
  property :difficulty

  property :solution do
    property :content
    validates :content, presence: true
  end

  property :rubric do
    property :rubric
    validates :rubric, presence: true
  end

  validates :content, :lesson, presence: true
  validates :difficulty, presence: true
  validate :check_solution
  validate :check_rubric

  def validate_and_save(question_params)
    return false unless validate(question_params)
    pts = question_params.delete :points
    @model.save
    @model.solution.update_attribute(:question_id, @model.id)
    @model.rubric.update_attribute(:question_id, @model.id)
    update_points(pts)
  end

  def check_solution
    if @model.solution.content.blank?
      errors.add :content, "Doesn't have solution."
    end
  end

  def check_rubric
    if @model.rubric.rubric.blank?
      errors.add :rubric, "Doesn't have rubric."
    end
  end

  def update_points(pts)
    unless pts[:qid].blank?
      pts[:pts] = pts[:pts].blank? ? 0 : pts[:pts]
      rlt = Relationship.create quiz_id: pts[:qid],
                                question_id: @model.id,
                                points: pts[:pts]
    end
    true
  end
end
