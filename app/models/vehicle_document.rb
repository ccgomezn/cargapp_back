class VehicleDocument < ApplicationRecord
  belongs_to :document_type
  belongs_to :statu
  belongs_to :user
  belongs_to :vehicle
  has_one_attached :file
end
