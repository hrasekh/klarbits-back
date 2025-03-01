class Answer < ApplicationRecord
  belongs_to :question
  validate :question_has_one_correct_answer
  validates :answer, presence: true
  validates :is_correct, inclusion: { in: [true, false] }
  has_many :answer_translations, dependent: :destroy

  def translated_answer(locale)
    answer_translations.find_by(locale: locale)&.content || answer
  end

  private

  def question_has_one_correct_answer
    return if question.answers.count(&:is_correct) <= 1

    errors.add(:question, 'must have exactly one correct answer')
  end
end
