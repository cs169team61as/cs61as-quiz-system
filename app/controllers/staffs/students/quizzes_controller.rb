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
      @quiz = Quiz.find(params[:quiz_id])
      @student = Student.find params[:student_id]
      @questions = @quiz.questions
      @subm = @questions.map { |q| q.submissions.find_by student: @student }
      @scores = @questions.map { |q| q.grades.find_by student: @student }
      @ques_subm = QuizSubmission.new(@questions, @subm, @scores).ques_subm

      tq = TakenQuiz.find_by student: @student, quiz: @quiz 
      # This needs double checking; isn't really great
      
      @ques_subm.each do |question, subm, score, rlt|
        grade = Grade.where(question_id: question.id,
                           student_id: @student.id,
                           lesson: question.lesson).first_or_create
        @grade_form = EditGradeForm.new grade

        autograder = subm.autograde
        oldg, newg = grade.grade, autograder[:credit].to_f

        my_params = {:grade => autograder[:credit], :comments =>  autograder[:comment] }
        if @grade_form.validate_and_save my_params 
          tq.update_attribute(:grade, tq.grade - oldg + newg)
        else
          flash[:error] = "Autograder failed, does not pass validation for question '#{question.content}'"
          break
        end
      end

      redirect_to staffs_student_quiz_path(@student.id, @quiz.id)
    end

    private

    def grade_params
      params.require(:grade).permit!
    end

  end
end
