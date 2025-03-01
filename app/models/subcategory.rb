class Subcategory < ApplicationRecord
  validates :name, presence: true
  belongs_to :category
  has_many :questions, dependent: :nullify
  validates :slug, presence: true

  before_validation :generate_slug

  def self.find_by_uuid(uuid)
    find_by(uuid: uuid)
  end

  private

  def generate_slug
    self.slug = name.parameterize if name_changed? || slug.blank?
  end
end
