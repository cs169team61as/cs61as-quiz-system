# Controller for Grades
module Staffs
  class GradesController < BaseController
    def index
      @all_to_grade = TakenQuiz.sort_quizzes TakenQuiz.not_graded
      if current_user.reader?
        @assigned = TakenQuiz.sort_quizzes current_user.taken_quizzes.not_graded
      end
    end

    def new
      qid, sid = params[:qid], params[:sid]
      @question = AbstractQuestion.find qid
      @grade = Grade.where(question_id: qid,
                           student_id: sid,
                           lesson: @question.lesson).first_or_create
      redirect_to edit_staffs_grade_path(@grade)
    end

    def edit
      grade = Grade.find params[:id]
      @submission = Submission.find_by question_id: grade.question_id,
                                       student_id: grade.student_id
      @question = @submission.question

      autograde = @submission.autograde
      grade[:grade] = autograde[:credit]
      grade[:comments] = autograde[:comment]

      @grade_form = EditGradeForm.new grade
      @rlt = Relationship.find_by question: @question,
                                  quiz: @submission.quiz
    end

    def update
      grade = Grade.find params[:id]
      oldg, newg = grade.grade, params[:grade][:grade].to_f
      @submission = Submission.find_by question_id: grade.question_id,
                                       student_id: grade.student_id
      @question = @submission.question
      @grade_form = EditGradeForm.new grade
      quiz = Quiz.find(params[:quiz_id])
      if @grade_form.validate_and_save grade_params
        tq = TakenQuiz.find_by student: grade.student, quiz: quiz
        # This needs double checking; isn't really great
        tq.update_attribute(:grade, tq.grade - oldg + newg)
        redirect_to staffs_student_quiz_path(grade.student_id, quiz)
      else
        @rlt = Relationship.find_by question_id: @question,
                                    quiz_id: @submission.quiz_id
        render 'edit'
      end
    end

    def download
      respond_to do |format|
        format.html { redirect_to staffs_dashboard_index_path }
        format.csv do
          send_data Student.get_csv(params[:lesson]),
                    filename: "lesson#{params[:lesson]}.csv"
        end
      end
    end

    def download_all
      respond_to do |format|
        format.csv do
          t = get_all_grades
          send_file t.path, filename: 'grades.zip',
                            type: 'application/zip',
                            disposition: 'attachment'
        end
      end
    end

    private

    def grade_params
      params.require(:grade).permit!
    end

    def get_all_grades
      files = Quiz::LESSON_VALUES.map do |q|

      end
      t = Tempfile.new(["my-temp-filename-#{Time.now}", '.zip'])
      Zip::File.open(t.path, Zip::File::CREATE) do |zipfile|
        Quiz::LESSON_VALUES.drop(1).each do |lesson|
          zipfile.get_output_stream("lesson#{lesson}.csv") do |f|
            f.write Student.get_csv(lesson)
          end
        end
        # zipfile.get_output_stream("myFile.,txt") { |os| os.write "myFile contains just this" }
      end
      t.close
      t
      # Zip::ZipOutputStream.open(t.path) do |zipfile|
      #   1/0
      #   Quiz::LESSON_VALUES.each do |lesson|
      #       zipfile.put_next_entry lesson
      #       zipfile.write Student.get_csv(lesson)
      #   end
      # end
      # t.close
    end
  end
end
