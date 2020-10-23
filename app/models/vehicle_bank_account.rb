class VehicleBankAccount < ApplicationRecord
  belongs_to :user
  belongs_to :vehicle
  belongs_to :statu
  has_one_attached :certificate
end
