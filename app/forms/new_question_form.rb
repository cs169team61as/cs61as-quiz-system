# Edit question here
class NewQuestionForm < Reform::Form

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
    return false unless validate(question_params)
    pts = question_params.delete :points
    @model.save :validate => false
    @model.solution.update_attribute(:question_id, @model.id)
    @model.rubric.update_attribute(:question_id, @model.id)
    @model.my_solution = question_params[:my_solution]
    @model.my_rubric = question_params[:my_rubric]
    update_points(pts)
  end


  def check_solution
    if @model.my_solution.blank?
      errors.add :content, "Solution can't be blank."
    end
  end

  def check_rubric
    if @model.my_rubric.blank?
      errors.add :rubric, "Rubric can't be blank."
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
