require 'spec_helper'

describe "TrueFalseQuestion" do
	def grade(answer)
		question.autograde({"answer" => answer}, quiz.id)[:credit]
	end

	let(:points) { 10 }
	let!(:question) do 
		q = TrueFalseQuestion.build :content => "Does 1+1 equal 2?", 
		:my_solution => "True", :my_rubric => "(empty)"
		q.save
		q
	end
	let!(:quiz) do
 		pq = build :quiz, retake: false, is_draft: false
  	pq.save(:validate => false)
  	pq.relationships.create!  question_id: question.id,
                            number: 1,
                            points: points
  	pq
	end
  
	it "should give full credit for the right answer" do
		expect(grade("True")).to eq points
	end
  
  	it "should give no credit toward the wrong answer" do
    	expect(grade("False")).to eq 0
 	end
  
	it "should return correct human readable content for graders" do
		expect(question.human_readable({"answer" => "True"})).to eq "True"
	end
end