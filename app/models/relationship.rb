# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  quiz_id     :integer
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  points      :integer          default(0)
#  number      :integer
#

# Relationship controller
class Relationship < ActiveRecord::Base
  default_scope -> { order 'number ASC' }
  belongs_to :quiz
  belongs_to :question, :class_name => "AbstractQuestion", :foreign_key => "question_id"
end
