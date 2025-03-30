class Question < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  has_many :answers, dependent: :destroy
  has_many :question_translations, dependent: :destroy
  validates :title, presence: true
  validates :question, presence: true
  validates :uuid, presence: true, uniqueness: true
  validate :category_matches_subcategory

  has_one_attached :image
  validate :acceptable_image, if: -> { image.attached? }

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

  def acceptable_image
    return unless image.attached?

    # Validate file size
    errors.add(:image, 'should be less than 5MB') unless image.byte_size <= 5.megabytes

    # Validate content type
    acceptable_types = ['image/jpeg', 'image/png', 'image/gif']
    return if acceptable_types.include?(image.content_type)

    errors.add(:image, 'must be a JPEG, PNG, or GIF')
  end

  def category_matches_subcategory
    return unless subcategory && category != subcategory.category

    errors.add(:subcategory, 'must belong to the same category as the question')
  end
end
