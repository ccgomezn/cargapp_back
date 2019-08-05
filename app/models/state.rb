class State < ApplicationRecord
  belongs_to :country
  validates :name, uniqueness: { scope: [:code, :country_id] }
  validates :name, presence: true
  validates :code, presence: true
end
