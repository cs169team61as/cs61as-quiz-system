# Other helpers
module ApplicationHelper
  def markdown(text)
    md_options = { autolink: true, no_intra_emphasis: true,
                   fenced_code_blocks: true, superscript: true,
                   highlight: true, quote: true }
    renderer_options = { hard_wrap: true, filter_html: true }

    highlight_syntax Redcarpet::Markdown.new(
      Redcarpet::Render::HTML.new(renderer_options), md_options
    ).render(text)
  end

  def highlight_syntax(html)
    doc = Nokogiri::HTML.fragment html
    doc.search('code[@class]').each do |code|
      code.replace Pygmentize.process(code.text.rstrip, code[:class])
    end
    doc.to_s.html_safe
  end

  def get_number(quiz, question)
    Relationship.find_by(question_id: question, quiz_id: quiz).number
  end

  def get_pts(quiz, question)
    Relationship.find_by(question_id: question, quiz_id: quiz).points
  end

  def get_type(question)
    AbstractQuestion.find_by(question_id: question).partial
  end

  def get_selections_for_request(request)
    quizzes = Quiz.where lesson: request.lesson, retake: request.retake, is_draft: false
    quizzes.map { |q| [q.to_s, q.id] }.unshift ["Random", nil]
  end

  def get_quiz_time_selections(request)
    option1 = 60
    option2 = 90
    option3 = 120
    id = request.student.id
    puts id
    quiztime = QuizTime.find_by(student_id: id)
    if quiztime != nil
      time = quiztime.time
    else
      time = 0
    end
    if time == option2
      return [option2, option1, option3].map { |time| ["#{time} minutes", time] }
    elsif time == option3
      return [option3, option1, option2].map { |time| ["#{time} minutes", time] }
    end
    return [option1, option2, option3].map { |time| ["#{time} minutes", time] }
  end
end
