# Form object for submissions
class TakeQuizForm < Reform::Form
  model :quiz

  property :lesson, virtual: true

  collection :new_submissions do
    property :question_content, virtual: true
    property :quiz_id
    property :question_id
    property :student_id
    property :content
    property :question
    validates :quiz_id, :question_id, :student_id, presence: true
  end

  def validate_and_save(params)
    return false unless validate(params)
    params[:new_submissions_attributes].each do |_, attrs|
      subm = Submission.find_by attrs.except(:content)
      subm.destroy if !subm.nil?
      Submission.create(attrs)
    end
  end
end
