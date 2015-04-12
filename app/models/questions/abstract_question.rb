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
#

class AbstractQuestion < ActiveRecord::Base
  
  has_many :relationships, dependent: :destroy
  has_many :quizzes, through: :relationships, foreign_key: 'quiz_id'
  has_many :grades
  has_many :submissions

  serialize :options, JSON

  self.table_name = "questions_v2"

# Initialize the default field values
  def build
    self.content = "(empty question)"
    self.options = Hash.new
    return
  end

# Return some sort of solution for the partial to render
  def solution; opt_solution; end

# Sets the solution to some value (when the question is created)
  def solution=(arg); opt_solution = arg; end

# Defines accessors for variables named opt_(.*)
# The variables are stored in the option hash.
  def method_missing(method_sym, *arguments, &block)
    if method_sym.to_s =~ /^opt_(.*)=$/
      options[$1.to_sym] = arguments.first
    elsif method_sym.to_s =~ /^opt_(.*)$/
      return options[$1.to_sym]
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