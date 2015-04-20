# Question Controller
module Staffs
  class QuestionsController < BaseController
    before_action :set_question, only: [:edit, :update, :destroy, :add]

    def new
      @question_type = params[:question_type]
      if params[:quiz_id]
        @quiz_id = params[:quiz_id]
        @quiz = Quiz.find params[:quiz_id]
        question = @question_type.classify.constantize.build lesson:  @quiz.lesson
        @add_pts = 'true'
      else
        question = @question_type.classify.constantize.build 
        @add_pts = 'false'
      end

      @lesson = 'true'
      @quest_form = question.new_form.new question
    end

    def create
      quiz = assign_params
      question = CreateQuestion.call(question_params.except(:points, :solution), params[:question_type])
      @quest_form = question.new_form.new question
      if @quest_form.validate_and_save question_params
        flash[:success] = 'Created Question!'
        redirect_after_editing quiz
      else
        render 'new'
      end
    end

    def index
      @lessons = Quiz::LESSON_VALUES
    end

    def show
      @question = AbstractQuestion.find params[:id]
    end

    def edit
      get_question_options
      @question = AbstractQuestion.find params[:id]
      @question_type = @question.type
      @quest_form = @question.edit_form.new @question
      @quest_form.populate_form_fields
      rlt = Relationship.find_by(quiz_id: params[:quiz_id],
                                 question: @question)
      @points = rlt.nil? ? 0 : rlt.points
    end

    def update
      quiz = assign_params
      @question = @question_type.classify.constantize.find(params[:id])
      @quest_form = @question.edit_form.new @question
      if @quest_form.validate_and_save question_params
        flash[:success] = 'Updated Question!'
        redirect_after_editing quiz
      else
        render 'edit'
      end
    end

    def destroy
      quizzes = @question.quizzes
      if quizzes.blank?
        @question.destroy
        flash[:success] = 'Deletion successful!'
      else
        used_by = quizzes.map(&:to_s).join ', '
        flash[:error] = "This question is being used by the following quizzes: #{used_by}. Please remove the question on the quiz(zes) first."
      end
      redirect_to :back
    end

    def bank
      @questions = AbstractQuestion.where(lesson: params[:lesson])
                           .includes(:solution).includes(:rubric)
                           .page params[:page]
      @requests = QuizRequest.all
      @add = params[:add] == 'true'
      @id = params[:quiz_id]
    end

    def add
      @quiz = Quiz.find params[:quiz_id]
      if @quiz.can_add? @question
        Relationship.where(question: @question, quiz: @quiz).first_or_create
        flash[:success] = 'Added question from question bank!'
      else
        @lesson = Quiz::LESSON_VALUES
        flash[:error] = 'This question has already been used on a retake!'
      end
      redirect_to edit_staffs_quiz_path @quiz
    end

    def download
      file = Tempfile.new('questions')
      AbstractQuestion.get_assigned_questions.each do |q|
        file.puts "Lesson: #{q.lesson} \n"
        file.puts "Difficulty: #{q.difficulty}\n"
        file.puts "Content:\n#{q.content.truncate 100 } \n\n"
        file.puts "Solution:\n#{q.solution.content}\n\n"
        file.puts "Rubric:\n#{q.rubric.rubric}\n\n"
        file.puts "Total Points: #{q.relationships.first.points}\n\n"
        file.puts "Average Points: #{q.get_average}\n\n\n\n"
      end
      send_file file, filename: 'questions.md'
      file.close
    end

    private

    def set_question
      @question = AbstractQuestion.find params[:id]
    end

    # Bad - explicitly require params
    def question_params
      params.require(params[:question_type]).permit!
    end

    def redirect_after_editing(quiz)
      if quiz
        redirect_to edit_staffs_quiz_path(quiz)
      else
        redirect_to staffs_questions_path
      end
    end

    def assign_params
      get_question_options
      @points = params[:points]
      question_params[:points] = { pts: @points, qid: @quiz_id }
      quiz = Quiz.find_by_id @quiz_id
    end

    def get_question_options
      @add_pts, @lesson, @quiz_id, @question_type = params[:add_pts], params[:lesson], params[:quiz_id], params[:question_type]
    end
  end
end
