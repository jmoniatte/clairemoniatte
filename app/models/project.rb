class Project < ApplicationRecord
  enum :status, { draft: 0, published: 1 }

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  before_validation :set_slug

  private

  def set_slug
    self.slug = title.to_s.strip.downcase.gsub(/\s+/, "-") if title.present?
  end
end
