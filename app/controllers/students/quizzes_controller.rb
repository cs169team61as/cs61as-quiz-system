module Students
  class QuizzesController < BaseController
    skip_before_filter :verify_authenticity_token, only: :submit

    def make_request
      lesson = params[:lesson]
      if can_take_quiz_for_lesson? lesson
        check_quiz_and_make_request(lesson)
      else
        flash[:alert] = "You can't request this quiz!"
      end
      redirect_to students_dashboard_path
    end

    def take
      quiz_lock = current_user.quiz_lock
      deny_access_unless! quiz_lock.present?
      @quiz_form = TakeQuizForm.new quiz_lock.quiz
      gon.push lock_path: lock_students_quiz_lock_path(quiz_lock),
               time_left: quiz_lock.time_left
    end

# Please refactor this method it smells
    def submit
      honest_statement_check = params[:honesty_statement]
      if honest_statement_check == nil
        flash[:error] = 'Please accept the academic honesty statement before submitting.'
        redirect_to take_students_quizzes_path
        return
      end

      ql = QuizLock.find_by_student_id(current_user.id)
      if ql.locked
        flash[:error] = 'You wish you could turn this in.'
        redirect_to students_dashboard_path
      else        
        #binding.pry

        @quiz_form = TakeQuizForm.new ql.quiz
        inject_current_user_into! params, ql.quiz
        if @quiz_form.validate_and_save params[:quiz]
          reader = Reader.assign_grader
          reader_id = reader ? reader.id : nil
          reader_login = reader ? reader.login : nil
          TakenQuiz.create student_id: ql.student_id,
                           quiz_id: ql.quiz.id,
                           lesson: ql.quiz.lesson,
                           retake: ql.quiz.retake,
                           reader_id: reader_id,
                           login: reader_login
          ql.destroy
          flash[:success] = "Submitted quiz #{@quiz_form.lesson}!"
          redirect_to students_dashboard_path

        else
          render 'take'
        end
      end
    end

    def show
      @grade = TakenQuiz.find params[:id]
      @quiz, @student = @grade.quiz, current_user
      @questions = @quiz.questions
      @subm = @questions.map { |q| q.submissions.find_by student: @student }
      @scores = @questions.map { |q| q.grades.find_by student: @student }
      @ques_subm = QuizSubmission.new(@questions, @subm, @scores).ques_subm
      @request = Regrade.find_by quiz: @quiz, student: @student
      @regrade = Regrade.new
      @not_graded = @scores.inject(false) { |q, q2| q || q2.nil? }
    end

    private

    def can_take_quiz_for_lesson?(lesson)
      (!current_user.making_request? || !current_user.taking_quiz?) &&
      current_user.number_of_taken_quizzes(lesson) < 2
    end

    def inject_current_user_into!(quiz_params, quiz)
      submissions_params = quiz_params[:quiz][:new_submissions_attributes]
      submissions_params.zip(quiz.questions).each do |sub, question|
        submission = sub[1]
        submission[:student_id] = current_user.id
        submission[:quiz_id] = quiz.id
        submission[:question_id] = question.id
      end
    end

    def check_quiz_and_make_request(les)
      re = current_user.number_of_taken_quizzes(les) != 0
      if !Quiz.has_quiz(les, re)
        flash[:notice] = "We don't currently have this quiz - please tell us!"
      else
        QuizRequest.create student: current_user, lesson: les, retake: re
        flash[:success] = "Requesting quiz #{params[:lesson]}!"
      end
    end
  end
end
