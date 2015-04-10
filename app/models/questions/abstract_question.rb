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

  attr_accessor :content

  has_many :relationships, dependent: :destroy
  has_many :quizzes, through: :relationships, foreign_key: 'quiz_id'

  serialize :options, JSON

  self.table_name = "questions_v2"

# some metaprogramming for easy attribute access?
  def method_missing(method_sym, *arguments, &block)
    if method_sym.to_s =~ /^opt_(.*)=$/
      self.options[$1.to_sym] = arguments.first
    elsif method_sym.to_s =~ /^opt_(.*)$/
      self.options[$1.to_sym]
    else
      super
    end
  end

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

  def full_credit(quiz_id)
  	points(quiz_id)
  end

# returns the credit given for the answer
  def autograde(answer)
  	return 0
  end

  def grade(answer)
    autograde(answer)
  end

  def partial
    self.class.name
  end

end