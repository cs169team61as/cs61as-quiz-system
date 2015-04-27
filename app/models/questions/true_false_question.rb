class TrueFalseQuestion < ShortAnswerQuestion
  def self.choices
    [%w(True True), %w(False False)]
  end
end