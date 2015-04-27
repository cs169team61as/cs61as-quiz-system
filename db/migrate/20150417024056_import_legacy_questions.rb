class ImportLegacyQuestions < ActiveRecord::Migration
# TODO -- actually test this mirgation
  def change
  	Question.includes(:solution, :rubric).each do |old|
  		if old.rubric and old.solution
  			q = ShortAnswerQuestion.build :content => old.content, 
  		                              :lesson => old.lesson, 
  		                              :difficulty => old.difficulty,
  		                              :solution => old.solution.read_attribute(old.content),
  		                              :rubric => old.rubric.read_attribute(old.rubric) 
  			q.save!

  			Grade.update_all(:question_id => q.id, :question_id => old.id)
  			Rubric.update_all(:question_id => q.id, :question_id => old.id)
  			Solution.update_all(:question_id => q.id, :question_id => old.id)
  			Relationship.update_all(:question_id => q.id, :question_id => old.id)
  			Submission.update_all(:question_id => q.id, :question_id => old.id)
        
  		end
  	end
  end
end