# frozen_string_literal: true

class Role < ApplicationRecord
  validates :name, :code, uniqueness: true
  validates :name, :code, presence: true

  before_create :default_values
  def default_values
    self.active ||= false
  end
end
