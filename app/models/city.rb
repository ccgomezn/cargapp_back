class City < ApplicationRecord
  belongs_to :state
  has_one :country, through: :state
  validates :name, uniqueness: { scope: [:code, :state_id] }
  validates :name, presence: true
  validates :code, presence: true
end
