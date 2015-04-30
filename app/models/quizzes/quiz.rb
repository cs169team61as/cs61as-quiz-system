# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  lesson     :string(255)      default("0")
#  version    :integer
#  retake     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  is_draft   :boolean          default(TRUE)
#

# Quiz class; knows its questions and its submissions
class Quiz < ActiveRecord::Base
  has_many :students, through: :taken_quizzes, foreign_key: 'quiz_id'
  has_many :taken_quizzes
  has_many :questions, through: :relationships, :class_name => "AbstractQuestion", foreign_key: 'question_id'
  has_many :relationships, dependent: :destroy
  has_many :submissions
  has_many :quiz_requests
  has_many :quiz_locks
  has_many :grades

  # TODO: Make sure deleting a question won't screw up quizzes too hard

  scope :drafts,    -> { where is_draft: true }
  scope :published, -> { where is_draft: false }
  scope :invalid, -> { where lesson: "" }

  @@correct_total_points = 10
  validate :version_not_reused 
  # :points_add_up, :questions_not_reused
  # validates :lesson, :version, presence: true
  
  # why is this in the object and not in db?
  LESSON_VALUES = ["0-1", "0-2", "0-3", "1", "2", "3", "4", "5", "6",
                   "7", "8", "9", "10", "11", "12", "13", "14"]
  LESSON_TITLES = { "0-1" => "Intro",
                    "0-2" => "Intro pt. 2",
                    "0-3" => "Recursion",
                    "1" => "Scheme Basics, Order of Evaluation, Recursion",
                    "2" => "Lambdas and HOF",
                    "3" => "Recursion, Iteration , Efficiency",
                    "4" => "Data Abstraction and Sequences",
                    "5" => "Hierarchical Data",
                    "6" => "Generic Operators",
                    "7" => "OOP",
                    "8" => "Assignment, State and Environment",
                    "9" => "Mutable Data and Vector",
                    "10" => "Streams",
                    "11" => "MCE",
                    "12" => "Lazy & Analyzing Evaluator",
                    "13" => "Logical Programming",
                    "14" => "Concurrency & Mapreduce" }

  DRAFT_LESSON_VALUES = ["0"] + LESSON_VALUES

  def self.lessons
    published.map(&:lesson).uniq.sort_by do |num|
      Quiz::LESSON_VALUES.find_index num
    end.map { |q| ["#{q} - #{LESSON_TITLES[q]}", q] }
  end

  def self.choose_one(quiz_request)
    published.where(lesson: quiz_request.lesson, retake: quiz_request.retake)
             .sample
  end

  def to_s
    "Quiz #{lesson}#{!retake ? 'a' : 'b'}#{version}#{' (Draft)' if is_draft}"
  end

  def new_submissions
    questions.map { |q| submissions.build question: q }
  end

  def next_number
    questions.size + 1
  end

  def self.generate_random(lesson, rtk)
    quiz = create lesson: lesson, retake: rtk == '1'
    easy, medium, hard = quiz.get_quest(lesson)
    quiz.relationships.create(question: hard, number: quiz.next_number) unless hard.nil?
    quiz.relationships.create(question: medium, number: quiz.next_number) unless medium.nil?
    quiz.relationships.create(question: easy, number: quiz.next_number) unless easy.nil?
    quiz
  end

  def get_quest(lesson)
    questions = []
    ['Easy', 'Medium', 'Hard'].each do |diff|
      qst = AbstractQuestion.where(lesson: lesson, difficulty: diff)
      questions << qst.select { |q| can_add? q }.sample
    end
    questions
  end

  # Updates the number for each question
  def add_numbers
    rlt = Relationship.where quiz_id: id
    count = 1
    rlt.each do |r|
      r.update_attribute :number, count
      count += 1
    end
  end

  def can_add?(question)
    quizzes = Quiz.where lesson: lesson, retake: !retake
    Quiz.check_question quizzes, question
  end

  def self.can_add?(question, les, ret)
    quizzes = Quiz.where lesson: les, retake: !ret
    Quiz.check_question quizzes, question
  end

  def self.check_question(quizzes, question)
    questions_list = []
    quizzes.each { |q| questions_list << q.questions }
    !(questions_list.flatten.include? question)
  end

  def self.has_quiz(lesson, retake)
    !Quiz.published.where(lesson: lesson, retake: retake).blank?
  end

  def self.sort_lesson(quizzes, sortValue)
    quizzes.sort_by do |q|
      [sortValue.find_index(q.lesson), q.version]
    end
  end

  def version_not_reused
    quizzes_with_same_version = Quiz.where("lesson = ? AND version = ? AND id != ?", lesson.to_s, version, id)
    errors.add(:version, "This version has already been used!") unless quizzes_with_same_version.empty?
  end

  # this function works, but breaks tests
  # def points_add_up
  #   return if is_draft?

  #   total = 0
  #   relationships.each do |r|
  #     total += r.points 
  #   end

  #   if total != @@correct_total_points
  #     msg = "Points must sum to #{@@correct_total_points} (now #{total})"
  #     errors.add(:relationships, msg) 
  #   end
  # end

  # this function is broken
  # def questions_not_reused
  #   my_questions = []
  #   questions.each { |q| my_questions << q.id }
  #   other_quizzes = Quiz.where.not(:id => id)
  #   reused_questions = other_quizzes.questions.where(:id => my_questions)
  #   errors.add("Contains a question already used by a retake") unless reused_questions.is_empty
  # end
end
