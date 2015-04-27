require 'spec_helper'

describe "TrueFalseQuestion" do
	def grade(content)
		question.autograde(content, quiz.id)[:credit]
	end

	let(:points) { 10 }

	let!(:question) do 
		q = TrueFalseQuestion.build :content => "Does 1+1 equal 2?"
		q.choice = "true"
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
  
	it "should give full credit if selected true" do
		expect(grade("true")).to eq points
	end
  
  it "should give no credit toward incorrect answer" do
    expect(grade("false")).to eq 0
  end
  
	it "should return correct human readable content for graders" do
		expect(question.human_readable("true")).to eq "Selected answer:\n\n\ * true\n"
	end
end