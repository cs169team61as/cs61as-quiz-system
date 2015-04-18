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
    q.content = "(empty question)"
    q.options = Hash.new
    q.options["rubric"] = "I don't have a rubric (#{q.partial})"
    q.options["solution"] = "I don't have a solution (#{q.partial})"

    [:content, :lesson, :difficulty].each do |a|
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

# How much credit should the student receive for the correct answer
  def full_credit(quiz_id); points(quiz_id); end

# Returns a hash that contains the credit given for the answer
# and the comment of why this much credit was given
  def autograde(answer, quiz_id)
    res = Hash.new
    res[:credit] = 0
    res[:comment] = "I don't know how to autograde this type yet (#{self.partial})"
    return res
  end

  def grade(answer, quiz_id); autograde(answer, quiz_id); end

# Returns the name of the partial to render
  def partial; self.class.name.underscore; end

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

end