require 'spec_helper'

describe "AllThatAppliesQuestion" do
	def grade(content)
		question.autograde(content, quiz.id)[:credit]
	end

	let(:points) { 10 }

	let!(:question) do 
		q = AllThatAppliesQuestion.build :content => "Which of these numbers are even?"
		q.choices = {"1" => false, "2" => true, "3" => false, "4" => true}
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


	it "should give full credit if all the correct boxes are checked and incorrect are not" do
		expect(grade({"2" => nil, "4" => nil})).to eq points
	end

	it "should give partial credit if some of the correct answers are checked" do
		expect(grade({"2" => nil})).to eq points/2
		expect(grade({"1" => nil, "2" => nil, "4" => nil})).to eq points/2
		expect(grade({"1" => nil, "2" => nil, "3" => nil, "4" => nil})).to eq 0
	end

	it "should not give less than zero credit" do
		expect(grade({"1" => nil, "3" => nil})).to eq 0
	end

	it "should not accept chioces without text when building" do
		q2 = AllThatAppliesQuestion.build :content => "Which of these numbers are even?", 
			:choices => {"1" => false, "2" => true, "3" => false, "4" => true, "" => false}
		expect(q2.choices[""]).to be_nil
	end
	
	it "should return correct human readable content for graders" do
		expect(question.human_readable({"1" => nil, "2" => nil, "4" => nil})).to eq "Selected answers:\n\n\ * 1\n\ * 2\n * 4\n"
	end
end