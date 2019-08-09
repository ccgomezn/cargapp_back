class Ticket < ApplicationRecord
  belongs_to :statu
  belongs_to :user
  has_one_attached :image
  has_one_attached :media
end
