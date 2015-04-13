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
  	if (self.question)
  		self.question.rubric
  	else
  		read_attribute(:rubric)
  	end
  end


# this breaks factorygirl
   def rubric=(val)
   	if (self.question)
   		self.question.rubric = val
   	else
   		write_attribute(:rubric, val)
   	end
   end

end
