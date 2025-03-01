class QuestionTranslation < ApplicationRecord
  belongs_to :question
  validates :locale, presence: true
  validates :content, presence: true
  validates :locale, uniqueness: { scope: :question_id, message: 'should be unique per question' }
end
