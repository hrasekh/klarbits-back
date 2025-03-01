class Category < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :questions, dependent: :destroy
  has_many :subcategories, dependent: :destroy
  validates :slug, presence: true, uniqueness: true

  before_validation :generate_slug

  def self.find_by_uuid(uuid)
    find_by(uuid: uuid)
  end

  private

  def generate_slug
    self.slug = name.parameterize if name_changed? || slug.blank?
  end
end
