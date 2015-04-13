# == Schema Information
#
# Table name: rubrics
#
#  id          :integer          not null, primary key
#  rubric      :text
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Rubric < ActiveRecord::Base
  belongs_to :question

  def rubric
  	self.queston.rubric
  end

  def rubric=(val)
  	self.queston.rubric = val
  end

end
