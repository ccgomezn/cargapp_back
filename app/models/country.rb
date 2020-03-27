# frozen_string_literal: true

class Country < ApplicationRecord
  validates :name, :code, :cioc, uniqueness: true
  validates :name, :code, :cioc, presence: true
  before_create :default_values
  before_save :default_values
  def default_values
    self.name = name.capitalize
  end
end
