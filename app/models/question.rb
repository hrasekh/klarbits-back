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

  # condtion
  validates :is_conditional, inclusion: { in: [true, false] }
  validates :condition, presence: true, if: :is_conditional?
  validates :condition, absence: true, unless: :is_conditional?
  validate :condition_code_is_valid_state, if: :is_conditional?

  before_validation :generate_uuid

  scope :base, -> { where(is_conditional: false) }
  scope :conditional, -> { where(is_conditional: true) }
  scope :with_condition_code, lambda { |conition_code|
    conditional.where(condition: conition_code)
  }

  GERMAN_STATE_CODES = {
    baden_wuerttemberg: 0,
    bavaria: 1,
    berlin: 2,
    brandenburg: 3,
    bremen: 4,
    hamburg: 5,
    hesse: 6,
    lower_saxony: 7,
    mecklenburg_vorpommern: 8,
    north_rhine_westphalia: 9,
    rhineland_palatinate: 10,
    saarland: 11,
    saxony: 12,
    saxony_anhalt: 13,
    schleswig_holstein: 14,
    thuringia: 15
  }.freeze

  def state_symbol
    return nil unless is_conditional? && condition.present?

    Question.german_state_codes.key(condition) # Find symbol by integer value
  end

  def state_symbol=(state_symbol)
    int_code = Question.german_state_codes[state_symbol]
    if int_code.present?
      self.is_conditional = true
      self.condition = int_code
    else
      self.is_conditional = false
      self.condition = nil
    end
  end

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

  def condition_code_is_valid_state
    return if condition.nil?

    return if Question.german_state_codes.value?(condition)

    errors.add(:condition, "'#{condition}' is not a valid German state code.")
  end
end
