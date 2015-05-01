require 'spec_helper'

describe "MultipleChoiceQuestion" do
	def grade(question, answer)
		question.autograde(submission(answer), quiz.id)[:credit]
	end

	def submission(answer)
		{"answer" => answer.to_s}
	end

	let!(:valid_question1) do 
		q = MultipleChoiceQuestion.build :content => "Where do you need to look to cross the street safely?",
			:choices => ["Right, then left", "Left, then right", "Up, then down", "It depends"], :answer => "3"
		q.save
		q
	end

	let!(:valid_question2) do 
		q = MultipleChoiceQuestion.build :content => "How many wings do you have?",
			:choices => ["zero", "one", "two", "six"], :answer => "0"
		q.save
		q
	end

	let!(:invalid_question_no_choices) do 
		q = MultipleChoiceQuestion.build :content => "I have no choices", :answer => "3"
		q.save
		q
	end

	let!(:invalid_question_no_answer) do 
		q = MultipleChoiceQuestion.build :content => "I have no answer",
			:choices => ["option1", "option2", "option3"]
		q.save
		q
	end

	let(:points) { 5 }
  	let!(:quiz) do
   		pq = build :quiz, retake: false, is_draft: false
    	pq.save(:validate => false)
    	pq.relationships.create!  question_id: valid_question1.id,
                              number: 1, points: points
        pq.relationships.create!  question_id: valid_question2.id,
                              number: 1, points: points
    	pq
  	end


	it "should give full credit for the right answer" do
		expect(grade(valid_question1, 3)).to eq points
		expect(grade(valid_question2, 0)).to eq points
	end
  
  	it "should give no credit for the wrong answer" do
  		expect(grade(valid_question1, 0)).to eq 0
  		expect(grade(valid_question1, 1)).to eq 0
  		expect(grade(valid_question1, 2)).to eq 0
  		expect(grade(valid_question2, 1)).to eq 0
  		expect(grade(valid_question2, 2)).to eq 0
  		expect(grade(valid_question2, 3)).to eq 0
	end

  	it "should give no credit for an out of bounds answer" do
		expect(grade(valid_question1, -1)).to eq 0
  		expect(grade(valid_question1, 7)).to eq 0
  		expect(grade(valid_question2, -1)).to eq 0
  		expect(grade(valid_question2, 7)).to eq 0
  	end

  	it "should give no credit for a non-numeric answer" do
		expect(grade(valid_question1, "blaaargshhhhfsh!!")).to eq 0 
		expect(grade(valid_question2, "blaaargshhhhfsh!!")).to eq 0
  	end
  
	it "should return correct human readable student's answer for graders" do
		valid_question1.choices.each_with_index do |text, id|
			expect(valid_question1.human_readable(submission(id))).to eq text
		end
	end

	it "should return correct human readable student's answer for graders when their answer is invalid" do
		expect(valid_question1.human_readable(submission("gsafkst"))).to match /invalid/
		expect(valid_question1.human_readable(submission(-6))).to match /invalid/
		expect(valid_question1.human_readable(submission(69))).to match /invalid/
		expect(invalid_question_no_choices.human_readable(submission(0))).to match /invalid/
		expect(invalid_question_no_answer.human_readable(submission(0))).to match /invalid/
	end

	it "should return a correct solution" do
		expect(valid_question1.my_solution).to eq "It depends"
		expect(valid_question2.my_solution).to eq "zero"
	end

	it "should return a correct solution when the answer is not valid" do
		expect(invalid_question_no_choices.my_solution).to match /invalid/
		expect(invalid_question_no_answer.my_solution).to match /invalid/
	end

	it "should give no credit if it's invalid" do
		expect(grade(invalid_question_no_choices, "blaaargshhhhfsh!!")).to eq 0
		expect(grade(invalid_question_no_answer, "blaaargshhhhfsh!!")).to eq 0
		expect(grade(invalid_question_no_answer, 3)).to eq 0
		expect(grade(invalid_question_no_choices, 0)).to eq 0
		expect(grade(invalid_question_no_choices, -1)).to eq 0
	end

	it "should not accept chioces without text when building" do
		q2 = MultipleChoiceQuestion.build :content => "How many legs do cats usually have?", 
			:choices => ["1", "2", "3", "4", ""], :answer => 3
		expect(q2.choices.include?("")).to be false
	end

	it "should validate the choices and the answer" do
		expect(invalid_question_no_choices).not_to be_valid
		expect(invalid_question_no_answer).not_to be_valid
		expect(valid_question1).to be_valid
		expect(valid_question1).to be_valid

		expect(invalid_question_no_answer.errors[:content].join(" ")).to match /answer/
		expect(invalid_question_no_choices.errors[:content].join(" ")).to match /choice/
	end

end