class Page < ApplicationRecord
  belongs_to :user

  validates :title,
            presence: true,
            uniqueness: true
  validates :content,
            presence: true

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(created_at: :desc) }
  scope :by_term, ->(term) do
    # hacemos un split de las palabras que nos ingresan en la busqueda
    # y vamos buscando por c/u de ellas
    term.gsub!(/[^-\w ]/, "") # limpiamos todo caracter que no sea alfanumerico
    terms = term.include?(" ") ? term.split : [ term ]

    pages = Page
    terms.each do |t|
      pages = pages.where("content ILIKE ?", "%#{t}%")
    end
    pages
  end

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
