class Room < ApplicationRecord
  belongs_to :service, optional: true
  belongs_to :user
  validates :service_id, uniqueness: { scope: [:user_id] }
end
