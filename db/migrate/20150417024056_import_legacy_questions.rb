class ImportLegacyQuestions < ActiveRecord::Migration
# TODO -- actually test this mirgation
  def up
  	Question.includes(:solution, :rubric).each do |old|
  		if old.rubric and old.solution
  			q = ShortAnswerQuestion.build :content => old.content, 
  		                              :lesson => old.lesson, 
  		                              :difficulty => old.difficulty,
  		                              :solution => old.solution.read_attribute(:content),
  		                              :rubric => old.rubric.read_attribute(:rubric) 
  			q.save!

  			Grade.where(:question_id => old.id).update_all(:question_id => q.id)
  			Rubric.where(:question_id => old.id).update_all(:question_id => q.id)
  			Solution.where(:question_id => old.id).update_all(:question_id => q.id)
  			Relationship.where(:question_id => old.id).update_all(:question_id => q.id)
  			Submission.where(:question_id => old.id).update_all(:question_id => q.id)
  		end
  	end
  end
end