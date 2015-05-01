require 'spec_helper'

describe "Autograde button" do 
	let(:staff) { create :reader }
	let(:student) { create :student }

	let!(:mc_question) { create :multiple_choice_question }
	let!(:mc_s) { create :submission, question: mc_question, student: student, 
		quiz: quiz, content: mc_question.opt_no_credit_submission }

    let!(:ata_question) { create :all_that_applies_question }
    let!(:ata_s) { create :submission, question: ata_question, student: student, 
    	quiz: quiz, content: ata_question.opt_no_credit_submission }

    let(:tf_question) { create :true_false_question }
    let!(:tf_s) { create :submission, question: tf_question, student: student, 
    	quiz: quiz, content: tf_question.opt_no_credit_submission }

    let!(:sa_question) { create :short_answer_question }
    let!(:sa_s) { create :submission, question: sa_question, student: student, 
    	quiz: quiz, content: tf_question.opt_no_credit_submission }

    let(:points) { 2 }

    let(:quiz) do
    	pq = build :quiz, retake: false, is_draft: false
    	pq.save(:validate => false)

    	pq.relationships.create! question_id: mc_question.id, 
    		number: 1, points: points
    	pq.relationships.create! question_id: ata_question.id, 
    		number: 2, points: points
    	pq.relationships.create! question_id: tf_question.id, 
    		number: 3, points: points
    	pq.relationships.create! question_id: sa_question.id, 
    		number: 4, points: points
    	pq
    end

    let!(:taken_quiz) { create :taken_quiz, student: student, 
    	quiz: quiz, reader: staff }

    let(:grade) { {:credit => points, :comment => "no comment"}  }

	before do
    	sign_in staff
    	visit staffs_grades_path
    	expect(page).to have_no_content "There are no quizzes to grade!"
        expect(page).to have_no_content "You have no assignments."
        expect(page).to have_content "Your Grading Assignments"
        expect(page).to have_content "#{taken_quiz}"
        visit staffs_student_quiz_path(taken_quiz.student, taken_quiz.quiz)
        expect(page).to have_content "Total"
    end

    it "should call autograde() on each question with the correct parameters" do
    	MultipleChoiceQuestion.any_instance.should_receive(:autograde).
    		with(mc_question.opt_no_credit_submission, quiz.id).and_return(grade)
    	ShortAnswerQuestion.any_instance.should_receive(:autograde).
    		with(tf_question.opt_no_credit_submission, quiz.id).and_return(grade)
    	TrueFalseQuestion.any_instance.should_receive(:autograde).
    		with(tf_question.opt_no_credit_submission, quiz.id).and_return(grade)
    	AllThatAppliesQuestion.any_instance.should_receive(:autograde).
    		with(ata_question.opt_no_credit_submission, quiz.id).and_return(grade)

        click_link "Autograde"

  	end
end