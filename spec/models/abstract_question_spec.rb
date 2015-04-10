require 'spec_helper'

class SampleQuestion < AbstractQuestion
	def initialize(question, answer)
		options = {:opt_answer => answer.to_s}
	end
end

describe "SampleQuestion inherited from AbstractQuestion" do

	let(:sample_text) {"What's the meaning of life?"}
	let(:sample_answer) {"42"}
  	let(:question) { SampleQuestion.new sample_text, sample_answer }
  	let(:sample_comment) {"Some random comment that shouldn't be there"}

	it "should have a credit given for its completion"

	it "should have a question text" do
		expect(question.content).to eq(sample_text)
	end

	it "should have opt_ accessors working" do
		expect(question.opt_answer).to eq(sample_answer)
		question.opt_comment = sample_comment
		expect(question.opt_comment).to eq(sample_comment)
	end

	it "should be able to store the metadata in the database and retrieve it back"

	it "should have the autograde() function" do
		begin
			grade = question.grade(nil)
		rescue
			fail
		end
	end

	it "should have a function returning the path to its partial" do
		begin
			path = question.partial
		rescue
			fail
		end
	end
end