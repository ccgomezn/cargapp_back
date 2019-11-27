class RoomUser < ApplicationRecord
  belongs_to :service
  belongs_to :room
  belongs_to :user
  #  validates :room_id, uniqueness: { scope: [:user_id] }
  # validates :service_id, uniqueness: { scope: [:user_id] }
end
