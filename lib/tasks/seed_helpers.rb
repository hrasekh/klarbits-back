# lib/tasks/seed_helpers.rb
module SeedHelpers
  module_function

  def seed_questions(file_path, subcategory_name)
    citizenship_category = Category.find_or_create_by!(name: 'Citizenship Test')
    subcategory = Subcategory.find_or_create_by!(name: subcategory_name, category: citizenship_category)
    seed_questions_from_file(file_path, citizenship_category, subcategory)
  end

  def seed_questions_from_file(file_path, category, subcategory)
    return Rails.logger.debug { "#{File.basename(file_path)} not found." } unless File.exist?(file_path)

    questions = JSON.parse(File.read(file_path))
    create_questions(questions, category, subcategory)
    Rails.logger.debug { "#{File.basename(file_path)} seeded, #{questions.count} questions created!" }
  end

  def create_questions(questions, category, subcategory)
    questions.each do |q|
      question = create_question_record(q, category, subcategory)
      create_translations(question, q['translations'])
      create_answers(question, q['answers'])
    end
  end

  def create_question_record(question_data, category, subcategory)
    Question.create!(
      title: question_data['title'],
      question: question_data['question'],
      category: category,
      subcategory: subcategory,
      is_conditional: question_data['is_conditional'] || false,
      condition: question_data['condition'] || nil
    )
  end

  def create_translations(question, translations)
    return unless translations

    translations.each do |locale, content|
      QuestionTranslation.create!(question: question, locale: locale, content: content)
    end
  end

  def create_answers(question, answers)
    answers.each do |a|
      answer = create_answer_record(a, question)
      create_answer_translations(answer, a['translations'])
    end
  end

  def create_answer_record(answer_data, question)
    Answer.create!(answer: answer_data['answer'], question: question, is_correct: answer_data['is_correct'])
  end

  def create_answer_translations(answer, translations)
    return unless translations

    translations.each do |locale, content|
      AnswerTranslation.create!(answer: answer, locale: locale, content: content)
    end
  end
end
