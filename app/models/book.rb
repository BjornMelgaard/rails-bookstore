class Book < ApplicationRecord
  belongs_to :category
  has_many :authorships, dependent: :destroy
  has_many :authors, through: :authorships

  validates :title, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.00 }
  validates :description, length: { maximum: 500 }

  mount_uploaders :covers, CoverUploader

  def create_associated_image(image)
    # covers << image
    require 'pry'; binding.pry;
    covers = [image]
    save!
  end

  def cover
    covers.first || CoverUploader.new
  end

  def to_s
    title
  end
end
