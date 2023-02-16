class Category < ApplicationRecord
  has_many :posts
  has_and_belongs_to_many :posts

  validates_uniqueness_of :name_ar, :name_en, :slug
  validates_length_of :name_ar, :name_en, :slug, minimum: 3, maximum: 100
  validates_format_of :slug, with: /\A[a-z]+\z/

  def to_s
    self.name_ar || self.name_en
  end
end
