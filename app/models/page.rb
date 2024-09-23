class Page < ApplicationRecord
  belongs_to :user

  validates :title,
            presence: true,
            uniqueness: true
  validates :content,
            presence: true

  scope :published, -> { where(published: true) }
  before_validation :make_slug

  private
  def make_slug
    self.slug = title
                .downcase
                .gsub(/[_ ]/, "-")
                .gsub(/[^-a-z0-9+]/, "")
                .gsub(/-{2,}/, "-")
                .gsub(/^-/, "")
                .chomp("-")
  end
end
