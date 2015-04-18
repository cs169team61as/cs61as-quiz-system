# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  lesson     :string(255)      default("")
#  difficulty :string(255)
#

# Model that represents questions
class Question < ActiveRecord::Base
  # default_scope -> { order 'lesson' }
  paginates_per 10

  has_many :relationships, dependent: :destroy
  has_many :quizzes, through: :relationships, foreign_key: 'quiz_id'
  has_many :grades
  has_many :submissions
  has_one :rubric, dependent: :destroy
  has_one :solution, dependent: :destroy

  # validate :rubric_present?

  def to_s
    "Question Lesson #{lesson}, #{difficulty}"
  end

  def self.levels
    [%w(Easy Easy), %w(Medium Medium), %w(Hard Hard)]
  end

  def number(quiz_id)
    relationships.find_by_quiz_id(quiz_id).number
  end

  def points(quiz_id)
    relationships.find_by_quiz_id(quiz_id).points
  end

  def get_average
    return "N/A" if grades.size == 0
    (grades.map { |g| g.grade }.sum / grades.size).round(3)
  end

  def get_total_points
  end

  def self.get_assigned_questions
    all.order('lesson').select { |q| !q.relationships.blank? }
  end

  private

  # def rubric_present?
  #   unless rubric.present?
  #     errors.add(:rubric, 'must be present')
  #   end
  # end
end
