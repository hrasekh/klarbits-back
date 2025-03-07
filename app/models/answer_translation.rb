class AnswerTranslation < ApplicationRecord
  belongs_to :answer
  validates :locale, presence: true
  validates :content, presence: true
  validates :locale, uniqueness: { scope: :answer_id }
end
