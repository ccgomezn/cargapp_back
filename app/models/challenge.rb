# frozen_string_literal: true

class Challenge < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :name, :point, presence: true
  validates :name, uniqueness: { scope: [:point] }

  before_create :build_create
  def build_create
    self.active ||= false
  end
end
