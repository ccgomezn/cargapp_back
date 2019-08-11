class Profile < ApplicationRecord
  belongs_to :document_type
  belongs_to :user
  has_one_attached :avatar
  validates :user_id, uniqueness: { scope: [:document_id] }
end
