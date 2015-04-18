# == Schema Information
#
# Table name: submissions
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  student_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  quiz_id     :integer
#

# Submission model
class Submission < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :question, :class_name => "AbstractQuestion", :foreign_key => "question_id"
  belongs_to :student
  serialize :content, JSON

  delegate :content, to: :question, prefix: true

  def autograde
  	question.autograde(content, quiz.id)
  end
end
