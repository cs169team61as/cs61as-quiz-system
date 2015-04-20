# Form object for editing quizzes
class EditQuizForm < Reform::Form
  include Reform::Form::ActiveRecord
  model :quiz

  property :lesson
  property :version
  property :retake
  property :is_draft

  validates :lesson, presence: true
  validates :version, presence: true, numericality: { greater_than: 0 }
  validates :retake, presence: true
  validates :is_draft, presence: true
  validate :points_add_to_10
  validate :check_lessons
  validate :check_questions
  validate :different_version

  def validate_and_save(quiz_params)
    return false unless validate(quiz_params)
    quiz = Quiz.find(id)
    quiz.add_numbers
    quiz.update_attributes(quiz_params)
  end

  private

  def points_add_to_10
    return true if @fields.is_draft.to_i == 1
    rlt = @model.relationships
    unless rlt.map { |r| r.points.to_i }.sum == 10
      errors.add :lesson, 'Points must sum to 10'
    end
  end

  def check_lessons
    return true if @fields.is_draft.to_i == 1
    rlt = @model.relationships
    unless !rlt.empty? && same_lesson(rlt)
      errors.add :lesson, 'Question lessons must match'
    end
  end

  def same_lesson(rlt)
    return true if @fields.is_draft.to_i == 1
    rlt.each do |r|
      quest = AbstractQuestion.find(r.question_id)
      return false if @fields.lesson != quest.lesson
    end
    true
  end

  def check_questions
    return true if @fields.is_draft.to_i == 1
    errors.add :retake, 'You have an invalid question!' unless right_questions
  end

  def right_questions
    @model.questions.each do |quest|
      return false unless Quiz.can_add? quest, @fields.lesson, @fields.retake.to_i == 1
    end
    true
  end

  def different_version
    q = Quiz.where(lesson: @fields.lesson,
                   version: @fields.version,
                   retake: @fields.retake.to_i == 1)
    unless q.size == 0 || @model == q[0]
      errors.add :version, 'This version has already been used!'
    end
  end
end
