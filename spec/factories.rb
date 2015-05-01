FactoryGirl.define do
  logins = ('aa'..'zz').to_a

  factory :student do
    first_name 'Student'
    sequence(:last_name) { |n| "#{n}" }
    sequence(:email) { |n| "student#{n}@gmail.com" }
    sequence(:login) { |n| "cs61as-a#{logins[n]}" }
    password 'password'
  end

  factory :staff do
    first_name 'Staff'
    sequence(:last_name) { |n| "#{n}" }
    sequence(:email) { |n| "staff#{n}@gmail.com" }
    sequence(:login) { |n| "cs61as-t#{logins[n]}" }
    password 'password'
  end

  factory :reader do
    first_name "Reader"
    sequence(:last_name) { |n| "#{n}" }
    sequence(:email) { |n| "reader#{n}@gmail.com" }
    sequence(:login) { |n| "cs61as-r#{logins[n]}" }
    password 'password'
  end

  factory :quiz do
    lesson '1'
    sequence(:version) { |n| n }
    retake false
    is_draft false
 
    factory :quiz_with_questions do
      ignore { questions_count 3 }

      after(:create) do |quiz, evaluator|
        evaluator.questions_count.times do |n|
          quiz.questions << create(:short_answer_question)
        end
      end
    end
  end

  factory :relationship do
    quiz_id     1
    question_id 1
    created_at  Time.now
    updated_at  Time.now
    points 0
    number 0
  end

  factory :rubric do
    rubric { Faker::Lorem.paragraph }
#    question
  end

  factory :solution do
    content { Faker::Lorem.paragraph }
#    question
  end

  factory :question do
    content { Faker::Lorem.paragraph }
    lesson '1'
    difficulty 'Easy'

    # after(:build) do |question|
    #   question.solution = create :solution, question: question unless question.solution
    #   question.rubric = create :rubric, question: question unless question.rubric
    # end
  end

  factory :abstract_question do
    initialize_with { ShortAnswerQuestion.build({}) }
    content { Faker::Lorem.paragraph }
    lesson '1'
    difficulty "Easy"

    after(:build) do |question|
      question.solution = create :solution, question: question unless question.solution
      question.rubric = create :rubric, question: question unless question.rubric
    end


    factory :short_answer_question do
      initialize_with { ShortAnswerQuestion.build({}) }
    end

    factory :multiple_choice_question do
      initialize_with do 
        MultipleChoiceQuestion.build({content: "Which hand do you use to write?",
            choices: ["Left", "Right", "Middle", "Upper"], answer: "1", my_rubric: "(none)",
            my_solution: "(none)", no_credit_submission: {"answer" => "3"}, 
            full_credit_submission: {"answer" => "1"}}) 
        end
    end

    factory :all_that_applies_question do
      initialize_with do 
        AllThatAppliesQuestion.build({content: "Where would you want to go for vacation?",
            choices: {"To prison" => false, "Somewhere" => true, "To Hawaii" => true, "To sewers" => false, 
              "To the office" => false}, my_rubric: "(none)", my_solution: "(none)", 
              no_credit_submission: {"choice_0" => "To prison", "correct_0" => "1"},
              half_credit_submission:  {"choice_0" => "To Hawaii", "correct_0" => "1"},
              full_credit_submission: {"choice_0" => "To Hawaii", "correct_0" => "1",
                "choice_1" => "Somewhere", "correct_1" => "1"}}) 
        end
    end

    factory :true_false_question do
      initialize_with { TrueFalseQuestion.build({content: "Are you a smart person??",
            my_rubric: "(none)", my_solution: "True", 
            no_credit_submission: {"answer" => "False"}, 
            full_credit_submission: {"answer" => "True"}}) }
    end

  end
  

  factory :quiz_request do
    sequence(:lesson) { |n| n }
    student
  end

  factory :quiz_lock do
    locked false
    student
    quiz
  end

  factory :submission do
    content { Faker::Lorem.paragraph }
    student
    quiz
    #question
  end

  factory :taken_quiz do
    student
    quiz
    reader
    grade 0
#    comment { Faker::Lorem.sentence }
    login { "cs61as-aa" }
    retake false
  end

  factory :grade do
    grade 3
    lesson "1"
#    question
    student
  end

  factory :regrade do
    student
    quiz
    questions "1"
    reason "Just Because"
  end
end
