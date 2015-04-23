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
  belongs_to :question, :class_name => "AbstractQuestion", :foreign_key => "question_id"

  def content
  	if (self.question)
  		self.question.my_solution
  	else
  		read_attribute(:content)
  	end
  end


  def content=(val)
	if (self.question)
  		self.question.my_solution = val
  	else
  		write_attribute(:content, val)
  	end
  end

end
