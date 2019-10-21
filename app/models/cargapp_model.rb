# frozen_string_literal: true

class CargappModel < ApplicationRecord
  validates :name, :code, :value, uniqueness: true
  validates :name, :code, :value, presence: true
  has_many :status
end
