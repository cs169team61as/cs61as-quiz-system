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
  	self.question.rubric
  end


# this breaks factorygirl
#   def rubric=(val)
#   	self.question.rubric = val
#   	write_attribute(:rubric, val)
#   end

end
