class ImportLegacyQuestions < ActiveRecord::Migration
  def change
  	ActiveRecord::Base.connection.execute("DELETE from \"questions_v2\"")
  	Question.all.each do |old|
  		q = ShortAnswerQuestion.build :content => old.content, :solution => old.solution.content, :rubric => old.rubric.rubric, :lesson => old.lesson, :difficulty => old.difficulty
  		q.save!
  	end
  end
end
