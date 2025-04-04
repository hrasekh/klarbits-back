require 'securerandom'
require 'json'

User.destroy_all
Category.destroy_all
Subcategory.destroy_all
Question.destroy_all
Answer.destroy_all
QuestionTranslation.destroy_all
AnswerTranslation.destroy_all

citizenship_category = Category.create!(name: "Citizenship Test")
citizenship_all_subcategory = Subcategory.create!(name: "All", category: citizenship_category)

questions = JSON.parse(File.read(Rails.root.join('db', 'seeds', 'questions.json')))

questions.each do |q|
  question = Question.create!(
    title: q["title"],
    question: q["question"],
    uuid: SecureRandom.uuid,
    category: citizenship_category,
    subcategory: citizenship_all_subcategory
  )
  q["translations"]&.each do |locale, content|
    QuestionTranslation.create!(question: question, locale: locale, content: content)
  end
  q["answers"].each do |a|
    answer = Answer.create!(answer: a["answer"], question: question, is_correct: a["is_correct"])
    a["translations"]&.each do |locale, content|
      AnswerTranslation.create!(answer: answer, locale: locale, content: content)
    end
  end
end
puts "Data seeded, #{questions.count} has been created!"

User.create!(
  email: ENV['ADMIN_EMIAL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  role: :admin
) unless User.exists?(email: ENV['ADMIN_EMAIL'])
puts "User admin has been created!"
