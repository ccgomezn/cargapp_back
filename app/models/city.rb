# frozen_string_literal: true

class City < ApplicationRecord
  belongs_to :state
  has_one :country, through: :state
  validates :name, uniqueness: { scope: %i[code state_id] }
  validates :name, presence: true
  validates :code, presence: true

  before_create :default_values
  before_save :default_values
  def default_values
    self.name = self.name.capitalize
  end
end
