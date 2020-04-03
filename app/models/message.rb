class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user

  # magen o archivos en los mensajes ?
  validates :uuid, :room_id, :user_id, :message, presence: true
  validates :uuid, uniqueness: true
  validates :user_id, uniqueness: { scope: %i[uuid room_id] }

  before_create :default_values
  def default_values
    self.active ||= false
  end
end
