# == Schema Information
#
# Table name: solutions
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

# Solution model
class Solution < ActiveRecord::Base
  belongs_to :question

  def content
  	if (self.question)
  		self.question.solution
  	else
  		read_attribute(:content)
  	end
  end

# this breaks factorygirl
  def content=(val)
	if (self.question)
  		self.question.solution = val
  	else
  		write_attribute(:content, val)
  	end
  end

end
