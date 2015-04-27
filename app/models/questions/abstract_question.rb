# == Schema Information
#
# Table name: questions_v2
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  lesson     :string(255)      default("")
#  difficulty :string(255)
#  options    :text
#  type       :string
#

=begin
  Short list of methods:
    build(options)
    option_accessor

    autograde(content, quiz_id), grade(content, quiz_id) 
    give_full_credit(msg, quiz_id)
    give_partial_credit(score, msg, quiz_id)
    give_no_credit(msg, quiz_id)
    normalize(score, quiz_id)

    human_readable(content)
    my_solution
    my_rubric

    new_form
    edit_form
    partial, type


  Methods (what they do):
    For subclassing quickly:
      build(options) - Creates a new question, factory-style. Example:
          q = ShortAnswerQuestion.build content: "What is the password?",
                                        my_solution: "1234"
                                        my_rubric: "*sigh*"
          q = AllThatAppliesQuestion.build content: "Which numbers are even?",
                                        choices: {"1" => false, "2" => true}                                        

      option_accessor - Declares fields that should be serialized and
                        stored in the "options" column of the database.
                        Example:

          def SampleQuestion < AbstractQuestion
            options_accessor my_awesome_field

            def autograde(quiz_id)
              return give_full_credit "Awesome!", quiz_id if my_awesome_field
              give_no_credit "Nope."
            end
          end
          ...

          # this question will give full credit
          q = SampleQuestion.build content: "Is the awesome field set?",
                                    my_awesome_field: true

          # this question will give no credit
          q = SampleQuestion.build content: "Is the awesome field set?",
                                    my_awesome_field: false

    For grading:
      autograde(content, quiz_id), grade(content, quiz_id) 
                  called to find how much credit 
                  the student should receive for this question
      give_full_credit(msg, quiz_id)
                  gives full credit for this answer.
                  Usage - from autograder function call: 
                  return give_full_credit(msg, quiz_id)
      give_partial_credit(score, msg, quiz_id)
                  gives SCORE points  for this answer.
                  Usage - from autograder function call:
                  return give_partial_credit(score, msg, quiz_id)
      give_no_credit(msg)
                  gives no credit for this answer
                  Usage - from autograder function call:
                  return give_no_credit(msg, quiz_id)
      normalize(score, quiz_id)
                  Makes sure the score is non-negative and 
                  less than full credit. Returns the corrected score.
    

    For display:
      human_readable(content) 
          parses the submitted student's answer into a string
          and returns this string. It will be displayed to graders
          and the students who look through their taken tests
      my_solution
          returns solution text (string) to be displayed to graders and staff
      my_solution
          returns rubric text (string) to be displayed to graders and staff


    For DRYness:
      new_form -  returns the Reform form for this type of question 
                  for creating new question
      edit_form - returns the Reform form for this type of question 
                  for editing old question
      partial, type - returns the string containing the partial to be 
                      rendered and question_type
=end

class AbstractQuestion < ActiveRecord::Base

  has_many :relationships, dependent: :destroy, :foreign_key => 'question_id'
  has_many :quizzes, through: :relationships, foreign_key: 'quiz_id'
  has_many :grades, :foreign_key => 'question_id'
  has_many :submissions, :foreign_key => 'question_id'

# ------ TODO: please refactor me -------
# Place this stuff in the options hash
  has_one :rubric, dependent: :destroy, :foreign_key => 'question_id'
  has_one :solution, dependent: :destroy, :foreign_key => 'question_id'
# ---------------------------------------

  serialize :options, JSON

  self.table_name = "questions_v2"

# Initialize the default field values and populate the options field
  def self.build(h={})
    q = self.new
    q.content = ""
    q.options = Hash.new

    #Commented out below in order to fix rspec test where you cannot leave
    #rubric, solution or question blank
    #q.options["rubric"] = "I don't have a rubric (#{q.partial})"
    #q.options["solution"] = "I don't have a solution (#{q.partial})"

    #replaced above two lines with:
    q.options["rubric"] = ""
    q.options["solution"] = ""

    [:content, :lesson, :difficulty, :my_solution, :my_rubric].each do |a|
      if h[a]
        q.send "#{a}=", h[a]
        h.delete a
      end
    end

    h.each do |key, value|
      q.options[key.to_s] = value
    end    
    return q
  end

# ======= TODO: refactor me ========
# Return some text that will go to the rubtic text field
  def my_rubric; options["rubric"]; end
  def my_rubric=(val); options["rubric"]=val; end

# Return some text that will go to the solution text field
  def my_solution; options["solution"]; end
  def my_solution=(val); options["solution"]=val; end

# ==================================

# Macro that allows you to define option accessors such as:
# option_accessor :answer, :comments, :blah

  def self.option_accessor(*args)
    args.each do |arg|
      self.class_eval "def #{arg}; options[\"#{arg}\"]; end"
      self.class_eval "def #{arg}=(val); options[\"#{arg}\"]=val; end"
    end
  end

# Defines accessors for variables named opt_(.*)
# The variables are stored in the option hash.
  def method_missing(method_sym, *arguments, &block)
    if method_sym.to_s =~ /^opt_(.*)=$/
      options[$1] = arguments.first
    elsif method_sym.to_s =~ /^opt_(.*)$/
      return options[$1]
    else
      super
    end
  end


# Returns a hash that contains the credit given for the answer
# and the comment of why this much credit was given
  def autograde(answer, quiz_id)
    give_no_credit "I don't know how to autograde this question type yet"
  end
  alias :grade :autograde

# Give maximum possible credit for this question
# msg is a string explaining why you gave this many points
# quiz_id is the id of the quiz this question is part of
  def give_full_credit(msg, quiz_id)
    res = Hash.new
    res[:credit] = full_credit(quiz_id)
    res[:comment] = msg #+ " (#{self.partial} autograder)"
    res
  end

# Give partial credit for this question
# score is how many points you give. 
# msg is a string explaining why you gave this many points
# quiz_id is the id of the quiz this question is part of
  def give_partial_credit(score, msg, quiz_id)
    score = normalize(score, quiz_id)
    res = Hash.new
    res[:credit] = score
    res[:comment] = msg #+ " (#{self.partial} autograder)"
    res
  end

# Make sure the score is non-negative and not bigger than 
# the full credit
  def normalize(score, quiz_id)
    max_score = full_credit(quiz_id)
    score = score >= 0 ? score : 0
    score = score <= max_score ? score : max_score
    score.round(1)
  end

# Give no credit for this question
# msg is a string explaining why you gave no credit
  def give_no_credit(msg)
    res = Hash.new
    res[:credit] = 0
    res[:comment] = msg #+ " (#{self.partial} autograder)"
    res
  end

# Represent the student's aswer as a string
# content - student's answer as a hash
  def human_readable(content)
    content.to_s
  end

# Returns the name of the partial to render
  def partial; self.class.name.underscore; end
  alias :type :partial

# Returns the correct form classes for this
# question type
  def new_form; ("New" + self.class.name + "Form").constantize; end
  def edit_form; ("Edit" + self.class.name + "Form").constantize; end

# ========= Methods the previous question class had =================

  def to_s
    "Question Lesson #{lesson}, #{difficulty}"
  end

  def self.levels
    [%w(Easy Easy), %w(Medium Medium), %w(Hard Hard)]
  end

  def number(quiz_id)
    relationships.find_by_quiz_id(quiz_id).number
  end

  def points(quiz_id)
    relationships.find_by_quiz_id(quiz_id).points
  end
  alias :full_credit :points
end