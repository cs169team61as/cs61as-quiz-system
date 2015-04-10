# == Schema Information
#
# Table name: other_questions
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

  serialize :options, JSON

# some metaprogramming for easy attribute access?
  def method_missing(method_sym, argument)
    if method_sym.to_s =~ /^opt_(.*)=$/
      options[$1.to_sym] = argument
    elsif method_sym.to_s =~ /^opt_(.*)$/
      options[$1.to_sym]
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

  def partial
    self.class.name
  end

end