class Question < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  has_many :answers, dependent: :destroy
  has_many :question_translations, dependent: :destroy
  validates :title, presence: true
  validates :question, presence: true
  validates :uuid, presence: true, uniqueness: true
  validate :category_matches_subcategory

  before_validation :generate_uuid

  def self.find_by_uuid(uuid)
    find_by(uuid: uuid)
  end

  def translated_question(locale)
    question_translations.find_by(locale: locale)&.content || question
  end

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid if uuid.blank?
  end

  def category_matches_subcategory
    return unless subcategory && category != subcategory.category

    errors.add(:subcategory, 'must belong to the same category as the question')
  end
end
