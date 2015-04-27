module Staffs::Students
  class QuizzesController < Staffs::BaseController
    def show
      @quiz = Quiz.find params[:id]
      @student = Student.find params[:student_id]
      @questions = @quiz.questions
      @subm = @questions.map { |q| q.submissions.find_by student: @student }
      @scores = @questions.map { |q| q.grades.find_by student: @student }
      @ques_subm = QuizSubmission.new(@questions, @subm, @scores).ques_subm
      @grade = TakenQuiz.find_by quiz: @quiz, student: @student
      @request = Regrade.find_by quiz: @quiz, student: @student
      @not_graded = @scores.inject(false) { |q, q2| q || q2.nil? }
    end

    def finish_grading
      student, quiz = params[:student_id], params[:quiz_id]
      TakenQuiz.find_by(student_id: student, quiz_id: quiz).finish
      Student.find(params[:student_id]).check_if_send_email
      regrade = Regrade.find_by(student_id: student, quiz_id: quiz)
      regrade.finish if regrade
      flash[:success] = 'Finished grading!'
      redirect_to staffs_grades_path
    end

    def autograde
      student_id, quiz_id = params[:student_id], params[:quiz_id]
      taken_quiz = TakenQuiz.find_by(student_id: student, quiz_id: quiz)

      @quiz = Quiz.find(params[:quiz_id])
      @student = Student.find params[:student_id]
      @questions = @quiz.questions
      @subm = @questions.map { |q| q.submissions.find_by student: @student }
      @scores = @questions.map { |q| q.grades.find_by student: @student }
      @ques_subm = QuizSubmission.new(@questions, @subm, @scores).ques_subm

      @ques_subm.each do |question, subm, score, rlt|
        grade = Grade.where(question_id: question.id,
                           student_id: student,
                           lesson: question.lesson).first_or_create

        autograde = subm.autograde
        grade[:grade] = autograde[:credit]
        grade[:comments] = autograde[:comment]

        oldg, newg = grade.grade, grade[:grade].to_f


        @grade_form = EditGradeForm.new grade
        quiz = Quiz.find(params[:quiz_id])

        tq = TakenQuiz.find_by student: grade.student, quiz: quiz
        tq.update_attribute(:grade, tq.grade - oldg + newg)

        binding.pry

        # my_params = {:grade => {:grade => grade[:grade],:comments =>  grade[:comments] }}

        # if @grade_form.validate_and_save my_params 
        #   tq = TakenQuiz.find_by student: grade.student, quiz: quiz
        #   # This needs double checking; isn't really great
        #   tq.update_attribute(:grade, tq.grade - oldg + newg)
        #   #redirect_to staffs_student_quiz_path(grade.student_id, quiz)
        # else
        #   @rlt = Relationship.find_by question_id: @question,
        #                               quiz_id: @submission.quiz_id
        # end
      end



      redirect_to staffs_student_quiz_path(student, quiz_id)
    end

    private

    def grade_params
      params.require(:grade).permit!
    end

  end
end
