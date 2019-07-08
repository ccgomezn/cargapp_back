# frozen_string_literal: true

class Role < ApplicationRecord
  validates :name, uniqueness: true
  validates :code, uniqueness: true
end
