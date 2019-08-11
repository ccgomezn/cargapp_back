class Challenge < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :name, uniqueness: { scope: [:point] }
end
