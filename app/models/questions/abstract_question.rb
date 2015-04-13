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
  
  has_many :relationships, dependent: :destroy
  has_many :quizzes, through: :relationships, foreign_key: 'quiz_id'
  has_many :grades
  has_many :submissions

  # some legacy relations so the controllers need less refactoring
  has_one :rubric, dependent: :destroy
  has_one :solution, dependent: :destroy

  serialize :options, JSON

  self.table_name = "questions_v2"

# Initialize the default field values and populate the options field
  def build(h={})
    self.content = "(empty question)"
    self.options = HashWithIndifferentAccess.new

    h.each do |key, value|
      if key == :content
        self.content = value
      end
      self.options[key.to_s] = value
    end
  end

# Return some sort of solution for the partial to render
  def solution; opt_solution; end

# Sets the solution to some value (when the question is created)
  def solution=(arg); opt_solution = arg; end

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

# Returns the credit given for the answer
  def autograde(answer); return 0; end
  def grade(answer); autograde(answer); end

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