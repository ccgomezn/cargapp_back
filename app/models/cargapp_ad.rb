# frozen_string_literal: true

class CargappAd < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one_attached :media
  validates :name, :price, :url, presence: true
  validates :name, uniqueness: { scope: %i[price body url] }
end
