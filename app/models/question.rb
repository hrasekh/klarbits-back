class Question < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory, optional: true
  has_many :answers, dependent: :destroy
  validates :content, presence: true
  validates :category, presence: true
  validates :uuid, presence: true, uniqueness: true 
  validate :category_matches_subcategory

  before_validation :generate_uuid

  def self.find_by_uuid(uuid)
    find_by(uuid: uuid)
  end

  private

  def generate_uuid
    self.uuid = SecureRandom.uuid if uuid.blank? 
  end

  def category_matches_subcategory
    if subcategory && category != subcategory.category
      errors.add(:subcategory, "must belong to the same category as the question")
    end
  end

end